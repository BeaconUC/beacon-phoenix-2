<script setup lang="ts">
  import { ref, shallowRef, onMounted, onBeforeUnmount, watch, computed } from 'vue'
  import { Map as MapLibre, NavigationControl, GeolocateControl, ScaleControl } from 'maplibre-gl'
  import { MapboxOverlay } from '@deck.gl/mapbox'
  import { HeatmapLayer, ContourLayer, ContourLayerProps } from '@deck.gl/aggregation-layers'
  import { MVTLayer } from '@deck.gl/geo-layers'
  import 'maplibre-gl/dist/maplibre-gl.css'

  interface OutageReport {
    id: number,
    public_id: string,
    status: string,
    description: string,
    location: {
      coordinates: [number, number]
    },
    created_at: string,
    image_url: string | null,
    linked_outage_id: number | null,
    barangay_id: number | null
  }

  const props = defineProps<{
    reports: OutageReport[]
    form: any
  }>()

  const mapContainer = ref<HTMLDivElement | null>(null)
  const isLoading = ref(true)
  const isLayerMenuOpen = ref(false)
  const showBarangays = ref(true)
  const activeLayerMode = ref<"heatmap" | "contour" | "both" | "none">("none")
  const pointerCoords = ref<{ lng: number, lat: number } | null>(null)
  const copySuccess = ref(false)
  const hoveredObject = ref<any>(null)

  const mapInstance = shallowRef<MapLibre | null>(null)
  const deckOverlay = shallowRef<MapboxOverlay | null>(null)

  const getPosition = (d: OutageReport): [number, number] => d.location.coordinates
  const getWeight = (_d: OutageReport) => 1
  // const MAP_STYLE = 'https://basemaps.cartocdn.com/gl/dark-matter-gl-style/style.json'
  const MAP_STYLE = '/static/liberty.json'

  const CONTOURS: ContourLayerProps['contours'] = [
    { threshold: [1, 5], color: [34, 197, 94, 150] },
    { threshold: [5, 15], color: [234, 179, 8, 150] },
    { threshold: [15, 30], color: [249, 115, 22, 150] },
    { threshold: [30, 1000], color: [239, 68, 68, 150]}
  ]

  const copyToClipboard = async (lng: number, lat: number) => {
    const text = `${lng.toFixed(5)}, ${lat.toFixed(5)}`
    try {
      await navigator.clipboard.writeText(text)
      copySuccess.value = true
      setTimeout(() => { copySuccess.value = false }, 2000)
    } catch (err) {
      console.error('Failed to copy: ', err)
    }
  }

  const activeOutageBarangayIds = computed(() => {
    return new Set(
      props.reports.flatMap(r => r.barangay_id !== null && r.barangay_id !== undefined ? [r.barangay_id] : [])
    )
  })

  let lastSpaceTime = 0;
  const DOUBLE_SPACE_DELAY = 300;
  const handleKeyDown = (e: KeyboardEvent) => {
    if (e.code === 'Space' && pointerCoords.value) {
      const now = Date.now();
      if (now - lastSpaceTime < DOUBLE_SPACE_DELAY) {
        e.preventDefault();
        copyToClipboard(pointerCoords.value.lng, pointerCoords.value.lat);
        lastSpaceTime = 0;
      } else {
        lastSpaceTime = now;
      }
    }
  };

  const getLayers = () => {
    const outageIds = activeOutageBarangayIds.value
    const newLayers = []

    if (showBarangays.value) {
      console.log("Adding barangay boundaries layer...");
      
      newLayers.push(new MVTLayer({
        id: 'barangay-boundaries',
        data: 'https://martin.jmcodes.com/barangays/{z}/{x}/{y}',
        pickable: true,
        autoHighlight: true,
        highlightColor: [0, 0, 0, 40],
        uniqueIdProperty: 'id',
        
        getFillColor: (d: any) => {
          const hasOutage = outageIds.has(d.properties.id)
          return hasOutage ? [220, 38, 38, 120] : [148, 163, 184, 40]

          // if (d.properties.id < 10) {
          //   return [220, 38, 38, 120]
          // } else {
          //   return [148, 163, 184, 40]
          // }
        },
        getLineColor: [51, 65, 85, 200],
        getLineWidth: 1,
        lineWidthMinPixels: 1,
        lineWidthUnits: 'pixels',

        onHover: info => {
          hoveredObject.value = info.object ? info : null;
        },

        updateTriggers: {
          getFillColor: [Array.from(outageIds)]
        },

        onClick: (info) => {
          if (info.object) {
            const { name, population } = info.object.properties
            console.log(`Barangay ${name} clicked. Pop: ${population}`)
            // trigger a Phoenix event or popup here
          }
        }
      }))
    }

    if (activeLayerMode.value === 'heatmap' || activeLayerMode.value === 'both') {
      newLayers.push(new HeatmapLayer({
        id: 'outage-heatmap',
        data: props.reports,
        getPosition,
        getWeight,
        radiusPixels: 80
      }))
    }

    if (activeLayerMode.value === 'contour' || activeLayerMode.value === 'both') {
      newLayers.push(new ContourLayer({
        id: 'outage-contours',
        data: props.reports,
        getPosition,
        getWeight,
        contours: CONTOURS,
        cellSize: 300,
        updateTriggers: { getPosition: [props.reports.length] }
      }))
    }
    return newLayers
  }

  const initializeMap = () => {
    if (!mapContainer.value || mapInstance.value) return

    const map = new MapLibre({
      container: mapContainer.value,
      style: MAP_STYLE,
      center: [120.5960, 16.4100],
      zoom: 12,
      pitch: 0,
      bearing: 0,
      attributionControl: false
    })

    mapInstance.value = map

    deckOverlay.value = new MapboxOverlay({
      interleaved: false,
      layers: getLayers(),
      getCursor: ({ isHovering }) => isHovering ? 'pointer' : 'crosshair'
    })

    map.addControl(new NavigationControl(), 'bottom-right')
    map.addControl(new GeolocateControl({
      positionOptions: { enableHighAccuracy: true },
      trackUserLocation: true
    }), 'bottom-right')
    map.addControl(new ScaleControl(), 'bottom-left')
    map.addControl(deckOverlay.value as any)

    map.on('mousemove', (e) => {
      pointerCoords.value = {
        lng: e.lngLat.lng,
        lat: e.lngLat.lat
      }
    })
    map.on('mouseout', () => {
      pointerCoords.value = null
    })
    // mapInstance.value.on('click', (e) => {
    //   copyToClipboard(e.lngLat.lng, e.lngLat.lat)
    // })

    map.on('load', () => {
      console.log("Map style loaded. Adding Martin layers...");

      isLoading.value = false
      map.resize()
    })
  }

  onMounted(() => {
    initializeMap()

    window.addEventListener('keydown', handleKeyDown);
  })

  watch([() => props.reports, activeLayerMode, showBarangays], () => {
    deckOverlay.value?.setProps({ layers: getLayers() })
  }, { deep: false })

  onBeforeUnmount(() => {
    window.removeEventListener('keydown', handleKeyDown);

    if (mapInstance.value) {
      if (deckOverlay.value) {
        mapInstance.value.removeControl(deckOverlay.value as any)
        deckOverlay.value.finalize()
      }
      mapInstance.value.remove()
      mapInstance.value = null
    }
  })
</script>

<template>
  <div class="map-wrapper" @click="isLayerMenuOpen = false">
    <div 
      v-if="hoveredObject && hoveredObject.object" 
      class="map-tooltip"
      :style="{ left: hoveredObject.x + 'px', top: hoveredObject.y + 'px' }"
    >
      <div class="font-bold text-blue-400">{{ hoveredObject.object.properties.name }}</div>
      <div class="text-xs opacity-70">Population: {{ hoveredObject.object.properties.population?.toLocaleString() }}</div>
      <div v-if="activeOutageBarangayIds.has(hoveredObject.object.properties.id)" class="mt-1 text-xs text-red-400 font-bold">
        ⚠️ ACTIVE OUTAGE
      </div>
    </div>

    <div class="top-right-controls" @click.stop @mouseenter="hoveredObject = null">
      <div class="flex flex-row gap-2 justify-end">
        <button 
          @click="showBarangays = !showBarangays"
          class="icon-btn"
          :class="{ 'active': showBarangays }"
          title="Toggle Barangay Boundaries"
        >
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 3H5a2 2 0 0 0-2 2v4m6-6h10a2 2 0 0 1 2 2v4M9 3v18m0 0h10a2 2 0 0 0 2-2V9M9 21H5a2 2 0 0 1-2-2V9"/></svg>
        </button>

        <div class="relative">
          <button 
            @click="isLayerMenuOpen = !isLayerMenuOpen"
            class="icon-btn"
            :class="{ 'active': isLayerMenuOpen }"
          >
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/><polyline points="3.27 6.96 12 12.01 20.73 6.96"/><line x1="12" y1="22.08" x2="12" y2="12"/></svg>
          </button>

          <Transition name="scale">
            <div v-if="isLayerMenuOpen" class="popover-menu">
              <span class="label">Analysis Mode</span>
              <div class="radio-group">
                <label v-for="mode in (['heatmap', 'contour', 'both', 'none'] as const)" :key="mode">
                  <input type="radio" v-model="activeLayerMode" :value="mode"> 
                  {{ mode.charAt(0).toUpperCase() + mode.slice(1) }}
                </label>
              </div>
            </div>
          </Transition>
        </div>
      </div>
    </div>

    <div class="top-left-controls" @click.stop @mouseenter="hoveredObject = null">
      <div 
        v-if="pointerCoords" 
        class="coords-pill" 
        :class="{ 'is-copied': copySuccess }"
        title="Double Space to copy coordinates"
      >
        <span v-if="!copySuccess">
          {{ pointerCoords.lng.toFixed(5) }}, {{ pointerCoords.lat.toFixed(5) }}
        </span>
        <span v-else class="success-text">
          COPIED COORDINATES!
        </span>
      </div>
    </div>

    <Transition name="fade">
      <div v-if="isLoading" class="loading-overlay">
        <div class="spinner"></div>
        <p>INITIALIZING MAP</p>
      </div>
    </Transition>

    <div ref="mapContainer" class="base-map"></div>
  </div>
</template>

<style scoped lang="scss">
.map-wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  background-color: #0f172a;
}

.base-map {
  width: 100%;
  height: 100%;

  :deep(.maplibregl-control-container) {
    cursor: crosshair;
    pointer-events: none;
    
    .maplibregl-ctrl {
      pointer-events: auto;
    }
  }
}

.map-tooltip {
  position: absolute;
  z-index: 1000;
  pointer-events: none;
  background: rgba(15, 23, 42, 0.9);
  padding: 8px 12px;
  border-radius: 8px;
  border: 1px solid rgba(51, 65, 85, 1);
  color: white;
  font-size: 0.75rem;
  transform: translate(15px, 15px);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.4);
}

.top-right-controls {
  position: fixed;
  top: 3.75rem;
  right: 0.6rem;
  z-index: 100;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.top-left-controls {
  position: fixed;
  top: 3.75rem;
  left: 0.6rem;
  z-index: 100;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.icon-btn {
  width: 2.75rem;
  height: 2.75rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(30, 41, 59, 0.9);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(71, 85, 105, 1);
  border-radius: 0.75rem;
  color: #94a3b8;
  cursor: pointer;
  transition: all 0.2s ease;

  svg {
    width: 1.25rem;
    height: 1.25rem;
  }
  &:hover {
    color: white;
    background: rgba(51, 65, 85, 1);
    transform: translateY(-2px);
  }
  &.active {
    color: #3b82f6;
    border-color: #3b82f6;
    background: rgba(30, 41, 59, 1);
  }
}

.popover-menu {
  position: absolute;
  top: 3.5rem;
  right: 0;
  width: 11rem;
  background: rgba(15, 23, 42, 0.95);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(51, 65, 85, 1);
  border-radius: 0.75rem;
  padding: 1rem;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.5);
  transform-origin: top right;

  .label {
    display: block;
    font-size: 0.65rem;
    font-weight: 800;
    text-transform: uppercase;
    color: #64748b;
    margin-bottom: 0.5rem;
  }
}

.radio-group { display: flex; flex-direction: column; gap: 0.5rem; 
  label {
    font-size: 0.85rem;
    color: #cbd5e1;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;

    &:hover {
      color: white;
    } 
    input {
      accent-color: #3b82f6;
    }
  }
}

.controls-card {
  padding: 0.75rem;
  margin-top: 3rem;
  background: rgba(30, 41, 59, 0.95);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(71, 85, 105, 1);
  border-radius: 0.5rem;
  color: white;
  display: flex;
  flex-direction: column;
  gap: 0.4rem;

  .label {
    font-size: 0.65rem;
    font-weight: 800;
    text-transform: uppercase;
    opacity: 0.5;
    margin-bottom: 0.1rem;
  }

  label {
    font-size: 0.85rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
    &:hover { opacity: 0.8; }
  }
}

.coords-pill {
  padding: 0.25rem 0.75rem;
  background: rgba(15, 23, 42, 0.85);
  backdrop-filter: blur(4px);
  border: 1px solid rgba(51, 65, 85, 1);
  border-radius: 9999px;
  color: #94a3b8;
  font-family: ui-monospace, monospace;
  font-size: 0.75rem;
  cursor: pointer;
  transition: all 0.2s ease;
  user-select: none;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.2);

  &:hover {
    background: rgba(30, 41, 59, 1);
    border-color: #3b82f6;
    color: #f8fafc;
    transform: translateY(-1px);
  }

  &.is-copied {
    background: #166534;
    border-color: #22c55e;
    color: #f0fdf4;
  }

  .success-text {
    font-weight: 700;
    letter-spacing: 0.05em;
  }
}

.loading-overlay {
  position: absolute;
  inset: 0;
  z-index: 200;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #0f172a;
  color: #bfdbfe;

  .spinner {
    width: 2.5rem; height: 2.5rem;
    border: 3px solid #3b82f6; border-top-color: transparent;
    border-radius: 50%; animation: spin 1s linear infinite;
  }

  p { margin-top: 1rem; font-family: monospace; font-size: 0.8rem; }
}

@keyframes spin { to { transform: rotate(360deg); } }
.scale-enter-active, .scale-leave-active { transition: all 0.2s ease; }
.scale-enter-from, .scale-leave-to { opacity: 0; transform: scale(0.95); }
.fade-leave-active { transition: opacity 0.4s ease; }
.fade-leave-to { opacity: 0; }
</style>