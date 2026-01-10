import maplibregl from "maplibre-gl";

export const Maplibre = {
    mounted() {
        this.map = new maplibregl.Map({
            container: this.el,
            style: '/static/liberty.json',
            center: [120.5960, 16.4023],
            zoom: 12
        });

        this.map.on('load', () => {
            this.map.addSource('beacon', {
                type: 'vector',
                tiles: ['http://ovh-vps:3050/barangays/{z}/{x}/{y}'],
                minzoom: 0,
                maxzoom: 12,
                scheme: 'xyz'
            });

            this.map.addLayer({
                id: 'barangay-layer',
                type: 'line',
                source: 'beacon',
                'source-layer': 'barangays',
                layout: { "line-join": 'round' },
                paint: { 'line-color': '#333', 'line-width': 1.5, 'line-blur': 0.5 }
            });

            this.map.on('click', 'barangay-layer', (e) => {
                if (e.features.length > 0) {
                    const props = e.features[0].properties;
                    this.pushEvent('barangay_selected', {
                        id: props.id,
                        name: props.name || 'Unknown'
                    });
                }
            });

            this.map.on('mouseenter', 'barangay-layer', () => {
                this.map.getCanvas().style.cursor = 'pointer';
            });
            this.map.on('mouseleave', 'barangay-layer', () => {
                this.map.getCanvas().style.cursor = '';
            });
        });
    },
    destroyed() {
        this.map?.remove();
    }
};
