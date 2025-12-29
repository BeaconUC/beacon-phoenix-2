export const Geolocation = {
    mounted() {
        this.el.addEventListener("click", e => {
            if ("geolocation" in navigator) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const { latitude, longitude } = position.coords;

                    this.pushEvent("set_location", { lat: latitude, lng: longitude });
                }, (error) => {
                    console.error("Error getting location", error);
                });
            }
        });
    }
};