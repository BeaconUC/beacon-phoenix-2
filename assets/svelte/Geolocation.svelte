<script>
    import Geolocation from "svelte-geolocation";
    import { onMount } from "svelte";

    let { live } = $props();
    let barangay = $state(null);
    let coords = $state({
        latitude: null,
        longitude: null,
        accuracy: null,
    });
    let lastSent = $state(null);

    onMount(() => {
        live.handleEvent("request_location", (_) => {
            if (coords.latitude && coords.longitude) {
                live.pushEvent("set_location", {
                    latitude: coords.latitude,
                    longitude: coords.longitude,
                });
            }
        });

        live.handleEvent("set_barangay", (payload) => {
            console.log("Received barangay:", payload.barangay);
            barangay = payload.barangay ?? "";
        });
    });

    function previewBarangay() {
        if (!coords.latitude || !coords.longitude) return;

        if (lastSent) {
            const dLat = Math.abs(coords.latitude - lastSent.lat);
            const dLng = Math.abs(coords.longitude - lastSent.lng);

            // ~10 meters
            if (dLat < 0.0001 && dLng < 0.0001) return;
        }

        lastSent = {
            lat: coords.latitude,
            lng: coords.longitude,
        };

        live.pushEvent("get_barangay", {
            latitude: coords.latitude,
            longitude: coords.longitude,
        });
    }
</script>

<Geolocation
    getPosition
    let:loading
    let:success
    let:error
    let:notSupported
    on:position={(e) => {
        const rawCoords = e.detail.coords;
        console.log("Geolocation position received:", rawCoords);

        coords = {
            latitude: rawCoords.latitude,
            longitude: rawCoords.longitude,
            accuracy: rawCoords.accuracy,
        };

        previewBarangay();
    }}
>
    <div class="my-5 space-y-2">
        <div class="flex items-center gap-4">
            {#if notSupported}
                <p class="text-sm text-red-600">Geolocation not supported</p>
            {:else}
                {#if loading}
                    <p class="text-sm text-gray-600">Fetching location...</p>
                {/if}

                {#if error}
                    <p class="text-sm text-red-500">
                        Cannot get location. {error.message}
                    </p>
                {/if}

                {#if success}
                    <div
                        class="flex items-stretch text-sm font-medium bg-[oklch(var(--color-primary))] text-[oklch(var(--color-primary-content))]"
                    >
                        <svg
                            class="w-5 mr-2 flex-shrink-0"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                clip-rule="evenodd"
                            />
                        </svg>
                        <div>
                            {#if barangay}
                                <p>
                                    Detected barangay: <span class="font-semibold">{barangay}</span>
                                </p>
                            {:else}
                                <p>
                                    Unable to determine barangay from location. You may be outside the service area (Baguio City).
                                </p>
                            {/if}
                            <p>
                                Location captured: <span class="font-semibold">({coords.latitude?.toFixed(6)}, {coords.longitude?.toFixed(6)})</span>
                            </p>
                            <p>
                                Accuracy: <span class="font-semibold">{coords.accuracy?.toFixed(2)} meters</span>
                            </p>
                            <p class="font-semibold mt-2">
                                Note: Preview only. Location will be requested again upon form submission.
                            </p>
                        </div>
                    </div>
                {/if}
            {/if}
        </div>
    </div>
</Geolocation>
