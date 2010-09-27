package com.universalmind.controllers {
import com.mapquest.LatLng;
import com.universalmind.delegates.SearchDelegate;
import com.universalmind.events.SetupEvent;
import com.universalmind.events.LocalSearchEvent;
import com.universalmind.models.IApplicationModel;

import com.universalmind.models.ISearchModel;

import flash.events.Event;
import flash.events.GeolocationEvent;
import flash.net.URLRequest;

import flash.sensors.Geolocation;

import mx.controls.Alert;
import mx.rpc.events.ResultEvent;

import org.swizframework.controller.AbstractController;

public class SearchController extends AbstractController{

        [Inject]
        public var appModel:IApplicationModel;

        [Inject]
        public var searchModel:ISearchModel;

        [Inject]
        public var delegate:SearchDelegate;

        private var cfm:String = "http://andypowell.org/localSearch/getXML.cfm?";

        public function SearchController() {
        }

        [Mediate( event="LocalSearchEvent.DO_SEARCH", properties="term" )]
        public function doSearch(term:String):void{

            executeServiceCall(delegate.searchLocal(term,appModel.latitude,appModel.longitude),doSearch_onResult);

        }

        private function doSearch_onResult(event:ResultEvent):void{
            searchModel.searchResult=event.result.ResultSet as Object;
            searchModel.placeResults();
        }

        private function buildURL(term:String,lat:Number,lon:Number):String{
            var url:String = this.cfm + "srchString=" + term + "&latitude=" + lat.toString() + "&longitude=" + lon.toString();
            return url;
        }

    }
}