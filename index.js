(function () {
    const api = window.SubwayBuilderAPI;
    const CITY_CODE = 'BNA';

    if (!api) return;

    // 1. Register Nashville
    api.registerCity({
        name: 'Nashville',
        code: CITY_CODE,
        description: 'The Music City',
        population: 689000,
        initialViewState: {
            zoom: 11.5,
            latitude: 36.1627,
            longitude: -86.7816,
            bearing: 0
        }
    });

    // 2. Register USA Tab
    api.cities.registerTab({
        id: 'usa',
        label: '🇺🇸 USA',
        cityCodes: [CITY_CODE]
    });
    // 3. Localhost tiles
    window.SubwayBuilderAPI.map.setTileURLOverride({
    	cityCode: 'BNA',
    	tilesUrl: 'http://127.0.0.1:8080/BNA/{z}/{x}/{y}.mvt',
    	foundationTilesUrl: 'http://127.0.0.1:8080/BNA/{z}/{x}/{y}.mvt',
    	maxZoom: 15
    });

    // 4. Data Files
    api.cities.setCityDataFiles(CITY_CODE, {
        buildingsIndex: '/data/BNA/buildings_index.json.gz',
        demandData: '/data/BNA/demand_data.json.gz',
        roads: '/data/BNA/roads.geojson.gz',
        runwaysTaxiways: '/data/BNA/runways_taxiways.geojson.gz',
	oceanDepth: '/data/BNA/ocean_depth_index.json.gz'
    });

    console.log('[Nashville Mod] Map paths and tiles updated.');
})();