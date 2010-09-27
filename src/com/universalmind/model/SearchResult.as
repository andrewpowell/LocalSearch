package com.universalmind.model {
    public class SearchResult {

        private var _title:String;
        private var _distance:Number;
        private var _phone:String;
        private var _lat:Number;
        private var _lon:Number;
        private var _address:String;
        private var _city:String;
        private var _state:String;


        public function SearchResult(src:Object) {
            this.title = src.Title;
            this.distance = src.Distance;
            this.phone = src.Phone;
            this.lat = src.Latitude;
            this.lon = src.Longitude;
            this.address = src.Address;
            this.city = src.City;
            this.state = src.State;
        }

        public function get title():String {
            return _title;
        }

        public function set title(value:String):void {
            _title = value;
        }

        public function get distance():Number {
            return _distance;
        }

        public function set distance(value:Number):void {
            _distance = value;
        }

        public function get phone():String {
            return _phone;
        }

        public function set phone(value:String):void {
            _phone = value;
        }

        public function get lat():Number {
            return _lat;
        }

        public function set lat(value:Number):void {
            _lat = value;
        }

        public function get lon():Number {
            return _lon;
        }

        public function set lon(value:Number):void {
            _lon = value;
        }

        public function get address():String {
            return _address;
        }

        public function set address(value:String):void {
            _address = value;
        }

        public function get city():String {
            return _city;
        }

        public function set city(value:String):void {
            _city = value;
        }

        public function get state():String {
            return _state;
        }

        public function set state(value:String):void {
            _state = value;
        }
    }
}