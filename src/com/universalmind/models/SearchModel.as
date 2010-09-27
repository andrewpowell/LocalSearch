package com.universalmind.models {
import com.mapquest.LatLng;
import com.universalmind.controllers.GeolocationController;
import com.universalmind.model.SearchResult;
import com.mapquest.tilemap.TilemapComponent;
import com.mapquest.tilemap.pois.MapIcon;
import com.mapquest.tilemap.pois.Poi;
import com.universalmind.events.LocalSearchEvent;

import flash.events.IEventDispatcher;

import flash.events.MouseEvent;

import flash.net.URLRequest;
import flash.net.navigateToURL;

import mx.collections.ArrayCollection;

public class SearchModel implements ISearchModel {

        private var _searchTerm:String;
        private var _searchResult:Object;
        private var _map:TilemapComponent;

        [Embed (source="/assets/blueball.png")]
        private var _centerImage:Class;

        [Dispatcher]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var appModel:IApplicationModel;

        public function SearchModel() {
        }

        public function get searchTerm():String {
            return _searchTerm;
        }

        public function set searchTerm(value:String):void {
            _searchTerm = value;
        }

        public function get searchResult():Object {
            return _searchResult;
        }

        public function set searchResult(value:Object):void {
            _searchResult = value;
        }

        public function get map():TilemapComponent {
            return _map;
        }

        public function set map(value:TilemapComponent):void {
            _map = value;
        }

        public function doSearch(term:String):void{
            dispatcher.dispatchEvent(new LocalSearchEvent(LocalSearchEvent.DO_SEARCH,term));
        }


        public function placeResults():void{
            this.map.setCenter(new LatLng(appModel.latitude,appModel.longitude),11);
            this.map.visible=true;
            trace(this.searchResult.toString());
            var results:ArrayCollection = searchResult.Result;
            var processedResult:ArrayCollection = new ArrayCollection();
            for(var i:int=0,n:int=results.length;i<n;i++){
                makePOIFromResult(new SearchResult(results.getItemAt(i)));
            }
        }

        private function makePOIFromResult(result:SearchResult):void{
            var poi:Poi = new Poi(new LatLng(result.lat,result.lon));
            poi.infoTitle=result.title;
            var strContent:String = new String();
            var newLine:String = "\n";
            strContent += result.address;
            strContent += newLine;
            strContent += result.city + ", " + result.state;
            strContent += newLine;
            strContent += result.phone;
            strContent += newLine;
            strContent += "Distance: " + result.distance.toString() + " miles.";
            poi.addEventListener(MouseEvent.DOUBLE_CLICK,function(e:MouseEvent):void{
                navigateToURL(new URLRequest("tel:"+result.phone.replace(/[^\d]/g, "")));    
            });
            poi.infoContent=strContent;
            map.addShape(poi);            
        }


    }
}