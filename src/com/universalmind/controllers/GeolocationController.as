package com.universalmind.controllers {
    import com.mapquest.LatLng;
    import com.mapquest.tilemap.pois.MapIcon;
    import com.mapquest.tilemap.pois.Poi;
    import com.universalmind.events.SetupEvent;
    import com.universalmind.models.IApplicationModel;

    import com.universalmind.models.ISearchModel;

    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.events.GeolocationEvent;
    import flash.sensors.Geolocation;

    public class GeolocationController {

        [Inject]
        public var searchModel:ISearchModel;

        [Inject]
        public var appModel:IApplicationModel;

        private var geo:Geolocation;
        private var embeddedIconPoi:Poi;
        private var geoOn:Boolean=false;

        [Embed (source="/assets/blueball.png")]
        private var _centerImage:Class;

        public function GeolocationController() {
        }

        [Mediate( event="LocalSearchEvent.DO_SEARCH", properties="term" )]
        public function test(term:String):void{
            trace("mediated");
        }

        [Mediate( event="InitializeGeocoderEvent.INITIALIZE")]
        public function setupGeo():void{
            onAppActivation(new Event(Event.ACTIVATE));
            setupStateListeners();
        }

        private function setupGeoListeners():void{
            geo=new Geolocation();
            geo.setRequestedUpdateInterval(1000);
            geo.addEventListener(GeolocationEvent.UPDATE, onGeolocationUpdate);
        }

        private function removeGeoListeners():void{
            geo.removeEventListener(GeolocationEvent.UPDATE, onGeolocationUpdate);
            geo=null;
        }

        private function setupStateListeners():void{
            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,onAppActivation);
            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,onAppDeactivation);            
        }

        private function onAppActivation(e:Event):void{
            if(!geoOn && Geolocation.isSupported){
                setupGeoListeners();
                geoOn=true;
            }
        }

        private function onAppDeactivation(e:Event):void{
            if(geoOn){
                removeGeoListeners();
                geoOn=false;
            }
        }

        private function onGeolocationUpdate(geoEvent:GeolocationEvent):void{
            this.appModel.latitude=geoEvent.latitude;
            this.appModel.longitude=geoEvent.longitude;
            if(this.searchModel.map!=null){
                searchModel.map.setCenter(new LatLng(this.appModel.latitude,this.appModel.longitude),9);

                try{
                    searchModel.map.removeShape(embeddedIconPoi);
                }
                catch(e:Error){
                    trace("Center icon doesn't exist.")
                }

                //make the poi
                embeddedIconPoi = new Poi(new LatLng(appModel.latitude,appModel.longitude));

                //make the icon from the embedded asset
                var myIcon:MapIcon = new MapIcon();
                myIcon.setImage(new _centerImage(),11,11);

                //set the icon to the embedded icon
                embeddedIconPoi.icon = myIcon;

                //set the rollover to state which poi it is
                embeddedIconPoi.infoTitle = "Current Location";

                //add the poi to the map
                searchModel.map.addShape(embeddedIconPoi);

                searchModel.map.visible=true;
                }
        }


    }
}