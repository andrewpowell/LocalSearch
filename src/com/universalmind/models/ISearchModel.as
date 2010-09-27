package com.universalmind.models {
import com.mapquest.tilemap.TilemapComponent;


public interface ISearchModel {

        function get searchTerm():String;
        function set searchTerm(value:String):void;

        function get searchResult():Object;
        function set searchResult(value:Object):void;

        function get map():TilemapComponent;
        function set map(value:TilemapComponent):void;

        function doSearch(term:String):void;
        function placeResults():void;
        

    }
}