/**
*Function that open the layers mesure
**/
function openMesureMenu(){
	// Si une autre page est ouverte
	if (window.OPENED_MENU != 'null'){
		hideMenu();
	}

	// We change is event on click
	document.getElementById('menus_button_mesure').setAttribute("onclick" , undefined);
	document.getElementById('menus_button_mesure').addEventListener('click' , hideMenu);

	// We display the div menu
	document.getElementById('menu').style.width = '350px';

	// We change the BG color of the button
	document.getElementById('menus_button_mesure').style.backgroundColor = 'rgba(180,180,180,1)';

	// We change the title
	document.getElementById('menu_container_title').innerHTML = 'MENU MESURER';

	// We add the layers option div
	document.getElementById('div_mesure_menu').style.display = 'block';

    // We add content to Mesure Menu
    document.getElementById('div_mesure_menu').innerHTML = "<div id='div_mesure_menu' style='display:block;width:100%;height:100%'><div style='width:100%;height:auto;display:flex;overflow:auto;'><div style='width:20px;'></div><div id='container_mesure_menu' style='width:100%;height:auto;overflow:auto;'></div><div style='width:20px;'></div></div></div>";


	// We load the module Mesure
	loadMesureModule();

	// We set the variable Opened Menu
	window.OPENED_MENU = 'Mesure';

}











/**
 * Function that load all the element inside the measure module
 * DO NOT FORGET TO CALL THIS FUNCTION IN SCRIPTS/DISPLAY.JS
 * 
 */
function loadMesureModule(){
    // get the html container
    var container = document.getElementById('container_mesure_menu');

    // set html var
    var html = '';

    // add subtittle tools
    html += "<h3 style='font-family:Ubuntu;color:white;font-size:20px;'>Outils:</h3>";
    html += "<div style='width:100%;height:2px;background-color:white;'></div>";
    html += "<div style='height:10px;'></div>";

    // add coords meaésure button
    html += "<button id='mesure_coords_button' class='module_button'><h3>Coordonnées d'un point</h3></button>";
    html += "<div style='height:7px;'></div>";

    // add linear measure button
    html += "<button id='mesure_linear_button' class='module_button'><h3>Mesurer une distance</h3></button>";
    html += "<div style='height:7px;'></div>";

    // add area measure button
    html += "<button id='mesure_area_button' class='module_button'><h3>Mesurer une surface</h3></button>";
    html += "<div style='height:7px;'></div>";


    // add subtittle result
    html += "<div style='height:15px;'></div>";
    html += "<h3 style='font-family:Ubuntu;color:white;font-size:20px;'>Résultats:</h3>";
    html += "<div style='width:100%;height:2px;background-color:white;'></div>";
    html += "<div style='height:10px;'></div>";
    html += "<div id='result_measure_container' style='width:100%'></div>";

    // add subtittle result
    html += "<div style='height:15px;'></div>";
    html += "<h3 style='font-family:Ubuntu;color:white;font-size:20px;'>Options:</h3>";
    html += "<div style='width:100%;height:2px;background-color:white;'></div>";
    html += "<div style='height:10px;'></div>";
    html += "<button id='mesure_remove_button' class='module_button' onclick='removeMeasure();'><h3>Supprimer les mesures</h3></button>";
    html += "<div style='height:7px;'></div>";
 
    // update container
    container.innerHTML = html;

    // draw legend
    drawMeasureLegend();

    // add event listener
    document.getElementById('mesure_coords_button').addEventListener('click' , initCoordsMeasure);
    document.getElementById('mesure_linear_button').addEventListener('click' , initLinearMeasure);

}


/**
 * Function to pick point in cesium and get it coordinates
 *
 */

function initCoordsMeasure(){
    // remove event listener
    document.getElementById('mesure_coords_button').removeEventListener('click' , initCoordsMeasure);

    // stop old measure
    stopMeasure();

    // get container
    var container = document.getElementById('container_mesure_menu');

    //Change the MEASURE_MODE VARIABLE
    window.MEASURE_MODE = 'COORDS';

    // change style
    document.getElementById('mesure_coords_button').style.backgroundColor = "#009EDF";
    document.getElementById('mesure_linear_button').style.backgroundColor = "#646464";
    document.getElementById('mesure_area_button').style.backgroundColor = "#646464";

    // add stop button
    container.innerHTML += "<button id='mesure_cancel_button' class='module_button'><h3>ANNULER</h3></button>";
    document.getElementById('mesure_cancel_button').style.backgroundColor = 'red';

    // add event listener
    document.getElementById('mesure_cancel_button').addEventListener('click' , stopMeasure);
    document.getElementById('cesiumContainer').addEventListener('pointerdown' , clickViewerNoMove);
}


/**
 * Function that display the coords of a clicked point on the menu and on the canvas
 * 
 * @param {event} e
 */
function getCoordsMeasure(e){
    // get the position of the clic
    var clickPosition = new Cesium.Cartesian2(e.offsetX , e.offsetY);

    // get the position in 3D
    try{
        var coords = viewer.scene.pickPosition(clickPosition);


        // transform to Geographic
        coords = Cesium.Cartographic.fromCartesian(coords);
        console.log(coords)

        // if the point is not at the good place
        if(coords.height > -1000 && coords.height < 10000){
            // transform to L93
            var coords2 = WGSToL93(coords.longitude*180/Math.PI , coords.latitude*180/Math.PI)
            
            // add the new measure to the liste of measure
            var point = {
                id: listeMeasure.Point.length,
                coordsWGS: {
                    longitude: coords.longitude*180/Math.PI,
                    latitude: coords.latitude*180/Math.PI,
                    height: coords.height
                },
                coordsL93:{
                    east: coords2[0],
                    north: coords2[1],
                    altitude: 0 
                },
                data:{}
            };
            listeMeasure.Point.push(point);

            // draw the object
            drawMeasure('POINT' , point.id);

            // reload legend container
            drawMeasureLegend();

        }
        
    } catch {
        console.log("error")
    }
}

/**
 * Function that init the tools measure linear
 * 
 */
function initLinearMeasure(){
    console.log('ptn');
    // remove event listener
    document.getElementById('mesure_linear_button').removeEventListener('click' , initLinearMeasure);

    // stop old measure
    stopMeasure();

    // get container
    var container = document.getElementById('container_mesure_menu');

    //Change the MEASURE_MODE VARIABLE
    window.MEASURE_MODE = 'LINEAR';

    // change style
    document.getElementById('mesure_coords_button').style.backgroundColor = "#646464";
    document.getElementById('mesure_linear_button').style.backgroundColor = "#009EDF";
    document.getElementById('mesure_area_button').style.backgroundColor = "#646464";

    // add stop button
    container.innerHTML += "<button id='mesure_cancel_button' class='module_button'><h3>ANNULER</h3></button>";
    document.getElementById('mesure_cancel_button').style.backgroundColor = 'red';

    // add event listener
    document.getElementById('mesure_cancel_button').addEventListener('click' , stopMeasure);
    document.getElementById('cesiumContainer').addEventListener('pointerdown' , clickViewerNoMove);
}

/**
 * Function that draw and measure a polyline
 * 
 * @param {event} e Click on the Cesium Viewer
 */
function getLinearMeasure(e){
    // get the position of the clic
    var clickPosition = new Cesium.Cartesian2(e.offsetX , e.offsetY);
}


/**
 * Function that remove all the drawed point, line and surface create by a measure
 * 
 */
function removeMeasure(){
    console.log('cc');
    // forEach point
    listeMeasure.Point.forEach(p => {
        p.data.label.destroy();
        p.data.billboard.destroy();
    });
    listeMeasure.Point = [];

    // Update legend container
    drawMeasureLegend();

    // Update viewer
    viewer.scene.requestRender();
}



/**
 * Function that stop the measure tools
 * 
 */
function stopMeasure(){
    // We destroy the cancel button
    try{document.getElementById('mesure_cancel_button').remove()}catch{}
    // We reset the event listener
    if(window.MEASURE_MODE == 'COORDS'){
        document.getElementById('mesure_coords_button').addEventListener('click' , initCoordsMeasure);
        document.getElementById('mesure_coords_button').style.backgroundColor = "#646464";
    }
    if(window.MEASURE_MODE == 'LINEAR'){
        document.getElementById('mesure_linear_button').addEventListener('click' , initLinearMeasure);
        document.getElementById('mesure_linear_button').style.backgroundColor = "#646464";
    }
    if(window.MEASURE_MODE == 'AREA'){
        
    }
    // We set the MEASURE MODE variable to undefined;
    window.MEASURE_MODE = undefined;

    // stop event click
    document.getElementById('cesiumContainer').removeEventListener('pointerdown' , clickViewerNoMove)

    
}


/**
 * Function that complete the div result of the measure module
 * 
 */
function drawMeasureLegend(){
    // get the div element
    var container = document.getElementById('result_measure_container');
    var html = '';

    // Add the point element
    listeMeasure.Point.forEach(p => {
        html += '<div id="measure_point_'+p.id+'" style="width:100%;background-color:white;padding:5px;box-sizing: border-box;">';
        html += '<h3 style="font-family:Ubuntu">Point '+(p.id+1)+'</h3>';
        html += '<p>Coordonnées WGS84:</p>';
        html += '<p style="color:#646464">Longitude: '+p.coordsWGS.longitude+'°</p>';
        html += '<p style="color:#646464">Latitude: '+p.coordsWGS.latitude+'°</p>';
        html += '<p style="color:#646464">Hauteur: '+p.coordsWGS.height+'m</p>';
        html += '<p></p>'
        html += '<p>Coordonnées Lambert 93:</p>';
        html += '<p style="color:#646464">Est:'+p.coordsL93.east+'m</p>';
        html += '<p style="color:#646464">Nord:'+p.coordsL93.north+'m</p>';
        html += '<p style="color:#646464">Altitude:'+p.coordsL93.altitude+'m</p>';
        html += '</div>';
        html += '<div style="height:5px;"></div>'
    });

    // add the linear element


    // add the surfaces element

    
    // update container
    container.innerHTML = html;
}

/**
 * Function that draw a measure in the viewer
 * 
 * @param {String} type Type of the measure ('POINT', 'LINE', 'AREA')
 * @param {int} id Id of the measure
 */
function drawMeasure(type , id){
    // if it is a point
    if(type == 'POINT'){
        // get element
        var m = listeMeasure.Point[id];

        // create point
        m.data.billboard = viewer.scene.primitives.add(new Cesium.BillboardCollection());
        m.data.billboard.add({
            position : new Cesium.Cartesian3.fromDegrees(m.coordsWGS.longitude, m.coordsWGS.latitude , m.coordsWGS.height),
            eyeOffset : new Cesium.Cartesian3(0.0,0.0,-100.0), // Negative Z will make it closer to the camera
            image : 'media/img/red_point.png',
            scale : 0.01,
            heightReference : Cesium.HeightReference.NONE
        });

        // create label
        m.data.label = viewer.scene.primitives.add(new Cesium.LabelCollection());
        m.data.label.add({
            position : Cesium.Cartesian3.fromDegrees(m.coordsWGS.longitude, m.coordsWGS.latitude , m.coordsWGS.height),
            text : 'Point '+(m.id+1),
            font : '15px Ubuntu',
            pixelOffset : new Cesium.Cartesian2(7,-7),
            eyeOffset : new Cesium.Cartesian3(0.0,0.0,-100.0),
            fillColor : Cesium.Color.RED
        })

        // update list
        listeMeasure.Point[id] = m;
        
        // update view
        viewer.scene.requestRender();

    }
}


/**
 * Function when we click on the cesium viewer and we don't move
 * 
 * @param {event} e Event pointerdown
 */
 function clickViewerNoMove(e){
    e.currentTarget.addEventListener('pointerup' , e2 => {
        if(e2.offsetX == e.offsetX && e2.offsetX == e.offsetX){
            // MEASURE COORDS
            if (window.MEASURE_MODE == 'COORDS'){
                getCoordsMeasure(e2);
                return;
            }
            // MEASURE LINEAR
            if (window.MEASURE_MODE == 'LINEAR'){
                console.log('ligne')
                return;
            }
        }
    } , {
        once: true
    });
}