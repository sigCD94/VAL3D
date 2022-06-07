function BimGroup() {
    this.maquettes = [];

    // METHOD
    /**
     * Function that add a Bim Project to the group
     * 
     * @param {BimProject} project;
     */
    this.add = function (project) {
        this.maquettes.push(project);
    }

    /**
     * Function that return a Bim Project by giving it id
     * 
     * @param {int} id id of the bim project to return;
     * @return {BimProject}
     */
    this.getProjectById = function (id) {
        for (var i = 0; i < this.maquettes.length; i++) {
            if (this.maquettes[i].id == id) {
                return this.maquettes[i];
            }
        }
    }

    /**
     * Function that update a Biim project in the liste
     * 
     * @param {BimProject} project Bim Project to update;
     */
    this.update = function (project) {
        for (var i = 0; i < this.maquettes.length; i++) {
            if (this.maquettes[i].id == project.id) {
                this.maquettes[i] = project;
                return;
            }
        }
    }
}



function BimProject(cfg) {
    // ATTRIBUTE
    this.id = cfg.id;
    this.name = cfg.name || 'Sans Titre';
    this.description = cfg.description || 'Sans description';
    this.path = cfg.path || '';
    this.display = false;
    this.fixedFrame;
    this.model;
    this.position;
    this.bgpolygon;
    this.bgpolygon2;


    // METHOD
    /**
     * Display a BIM Project on viewer
     * 
     */
    this.construct = function () {
        fetch(this.path + '/meta.json').then(a => a.json()).then(param => {
            this.fixedFrame = new Cesium.Transforms.eastNorthUpToFixedFrame(new Cesium.Cartesian3.fromDegrees(param.longitude, param.latitude, param.height));
            var translation = new Cesium.Cartesian3(0, 0, 0);
            var scale = new Cesium.Cartesian3(1, 1, 1);
            var axis = new Cesium.Cartesian3(0, 0, 1);
            var rotation = new Cesium.Quaternion.fromAxisAngle(axis, param.rotation / 180 * Math.PI);
            var matrix = new Cesium.Matrix4.fromTranslationQuaternionRotationScale(translation, rotation, scale);

            this.fixedFrame = Cesium.Matrix4.multiply(this.fixedFrame, matrix, new Cesium.Matrix4);

            this.model = viewer.scene.primitives.add(Cesium.Model.fromGltf({
                url: this.path + '/maquette.gltf',
                modelMatrix: this.fixedFrame,
                scale: param.scale
            }));

            // save position
            this.position = new Cesium.Cartesian3.fromDegrees(param.longitude, param.latitude, param.height);

            //set display
            this.display = true;

            // Update liste
            listeBIMs.update(this);

            // Add clipping plane
            if (param.envelop.length != 0) {


                let planes = [];
                for (let i = 0; i < param.envelop.length; i++) {
                    // Get the two extremity of each segments
                    let pointA = new Cesium.Cartesian3.fromDegrees(param.envelop[i][0], param.envelop[i][1]);
                    let pointB = new Cesium.Cartesian3.fromDegrees(param.envelop[(i + 1) % param.envelop.length][0], param.envelop[(i + 1) % param.envelop.length][1]);

                    console.log(pointA);
                    console.log(pointB);

                    // Get the vect AB normanlize
                    let ABvect = new Cesium.Cartesian3();
                    Cesium.Cartesian3.subtract(pointB, pointA, ABvect);
                    console.log(ABvect);

                    // Get the Zenith vector
                    let AzenithVect = viewer.scene.globe.ellipsoid.geodeticSurfaceNormal(pointA);
                    console.log(AzenithVect);

                    // Calc normal
                    let normal = new Cesium.Cartesian3();

                    normal.x = AzenithVect.y * ABvect.z - AzenithVect.z * ABvect.y;
                    normal.y = AzenithVect.z * ABvect.x - AzenithVect.x * ABvect.z;
                    normal.z = AzenithVect.x * ABvect.y - AzenithVect.y * ABvect.x;

                    console.log(normal);

                    // Create plane
                    let plane = new Cesium.Plane.fromPointNormal(pointA, normal);
                    planes.push(plane);

                }

                // Convert to clipping planes
                let clipping_planes = [];
                planes.forEach(p => {
                    clipping_planes.push(new Cesium.ClippingPlane.fromPlane(p));
                });

                console.log(clipping_planes);

                let clippingPlanes = new Cesium.ClippingPlaneCollection({
                    planes: clipping_planes,
                    unionClippingRegions: false,
                    modelMatrix: Cesium.Matrix4.inverse(listeLayers.getLayerById(1).data._initialClippingPlanesOriginMatrix, new Cesium.Matrix4()),
                });

                // Add it to the model
                listeLayers.getLayerById(1).data.clippingPlanes = clippingPlanes;

            }

            if (param.bgenvelop != undefined) {

                // CREATE BACKGROUND
                // this.bgpolygon = new Cesium.Polygon();
                let material = new Cesium.Color(0, 0, 0, 1);
                if (param.backgroundColor != undefined) {
                    material = new Cesium.Color(param.backgroundColor.r / 255, param.backgroundColor.g / 255, param.backgroundColor.b / 255, 1);
                }

                // Set position
                let positions = [];
                for (let i = 0; i < param.bgenvelop.length; i++) {
                    positions.push(new Cesium.Cartesian3.fromDegrees(param.bgenvelop[i][0], param.bgenvelop[i][1]));
                }

                this.bgpolygon = viewer.entities.add({
                    polygon: {
                        hierarchy: {
                            positions: positions
                        },
                        material: material,
                        height: param.height - 10,
                        zIndex: -1
                    }
                });


            }

            // Reload scene
            viewer.scene.requestRender();

            // Move camera
            this.flyTo();


        });
    }

    /**
     * Function that destroy a Bim project
     * 
     */
    this.destroy = function () {
        // remove model
        this.model.destroy();
        // clipping plane
        listeLayers.getLayerById(1).data.clippingPlanes = new Cesium.ClippingPlaneCollection({
            planes: []
        });

        //background
        if (this.bgpolygon != undefined) {
            viewer.entities.remove(this.bgpolygon);
        }

        // delete fixed frame
        this.fixedFrame = undefined;

        // set display
        this.display = false

        // Update liste
        listeBIMs.update(this);

        // Reload scene
        viewer.scene.requestRender();
    }

    /**
     * Function that let you fly to a BIM place
     * 
     * @param {BimProject} project Bim project we fly to;
     */
    this.flyTo = function () {
        // get coords
        var coords = this.position;

        // transform in Lon, Lat, height
        coords = Cesium.Cartographic.fromCartesian(coords);
        // add 300m height and 300m south
        coords.height += flyToPOIDistance * 100;
        coords.latitude -= flyToPOIDistance * 100 * coords.latitude / RAYON_TERRE;
        // coords to Cartesian
        coords = Cesium.Cartesian3.fromDegrees(coords.longitude * 180 / Math.PI, coords.latitude * 180 / Math.PI, coords.height)
        // move the camera
        viewer.camera.flyTo({
            destination: coords,
            orientation: {
                heading: Cesium.Math.toRadians(0.0),
                pitch: -Math.PI / 4
            }
        });
    }

}

