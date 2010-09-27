package com.universalmind.models {

    public class ApplicationModel implements IApplicationModel{

        private var _latitude:Number=39.149694767499994;
        private var _longitude:Number=-77.2136915125;

        public function ApplicationModel() {
        }

        public function get latitude():Number {
            return _latitude;
        }

        public function set latitude(value:Number):void {
            _latitude = value;
        }

        public function get longitude():Number {
            return _longitude;
        }

        public function set longitude(value:Number):void {
            _longitude = value;
        }
    }
}