function BimGroup(){
    this.maquettes = [];

    // METHOD
    /**
     * Function that add a Bim Project to the group
     * 
     * @param {BimProject} project;
     */
    this.add = function(project){
        this.maquettes.push(project);
    }

    /**
     * Function that return a Bim Project by giving it id
     * 
     * @param {int} id id of the bim project to return;
     * @return {BimProject}
     */
    this.getProjectById = function(id){
        for(var i =0 ; i < this.maquettes.length ; i++){
            if(this.maquettes[i].id == id){
                return this.maquettes[i];
            }
        }
    }

    /**
     * Function that update a Biim project in the liste
     * 
     * @param {BimProject} project Bim Project to update;
     */
    this.update = function(project){
        for(var i =0 ; i < this.maquettes.length ; i++){
            if(this.maquettes[i].id == project.id){
                this.maquettes[i] = project;
                return;
            }
        }
    }
}



function BimProject(cfg){
    // ATTRIBUTE
    this.id = cfg.id;
    this.name = cfg.name || 'Sans Titre';
    this.description = cfg.description || 'Sans description';
    this.path = cfg.path || '';
    this.display = false;
    this.fixedFrame;
    this.model;
    this.position;


    // METHOD
    /**
     * Display a BIM Project on viewer
     * 
     */
    this.construct = function(){
        fetch(this.path + '/meta.json').then(a => a.json()).then(param => {
            this.fixedFrame = new Cesium.Transforms.eastNorthUpToFixedFrame(new Cesium.Cartesian3.fromDegrees(param.longitude, param.latitude, param.height));
            var translation = new Cesium.Cartesian3(0,0,0);
            var scale = new Cesium.Cartesian3(1,1,1);
            var axis = new Cesium.Cartesian3(0,0,1);
            var rotation = new Cesium.Quaternion.fromAxisAngle(axis, param.rotation/180*Math.PI);
            var matrix = new Cesium.Matrix4.fromTranslationQuaternionRotationScale(translation, rotation, scale);

            this.fixedFrame = Cesium.Matrix4.multiply(this.fixedFrame , matrix , new Cesium.Matrix4);

            this.model = viewer.scene.primitives.add(Cesium.Model.fromGltf({
                url : this.path +'/maquette.gltf',
                modelMatrix : this.fixedFrame,
                scale : param.scale
            }));

            // save position
            this.position = new Cesium.Cartesian3.fromDegrees(param.longitude, param.latitude, param.height);

            //set display
            this.display = true;

            // Update liste
            listeBIMs.update(this);

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
    this.destroy = function(){
        // remove model
        this.model.destroy();

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
    this.flyTo = function(){
        // get coords
        var coords = this.position;

        // transform in Lon, Lat, height
        coords = Cesium.Cartographic.fromCartesian(coords);
        // add 300m height and 300m south
        coords.height += flyToPOIDistance*100;
        coords.latitude -= flyToPOIDistance*100*coords.latitude/RAYON_TERRE;
        // coords to Cartesian
        coords = Cesium.Cartesian3.fromDegrees(coords.longitude*180/Math.PI, coords.latitude*180/Math.PI, coords.height)
        // move the camera
        viewer.camera.flyTo({
            destination : coords,
            orientation : {
                heading : Cesium.Math.toRadians(0.0),
                pitch : -Math.PI/4
            }
        });
    }

}

