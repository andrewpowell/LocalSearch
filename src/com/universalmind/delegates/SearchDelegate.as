package com.universalmind.delegates {
import mx.rpc.AsyncToken;
import mx.rpc.http.HTTPService;

public class SearchDelegate {


        public var service:HTTPService=new HTTPService();

        private var cfm:String = "http://andypowell.org/localSearch/getXML.cfm?";

        public function SearchDelegate() {
            service.method="GET";
            service.resultFormat="object";
            service.showBusyCursor=true;
        }

        public function searchLocal(term:String,latitude:Number,longitude:Number):AsyncToken{
            var token:AsyncToken;
            service.url=buildURL(term,latitude,longitude);
            return service.send();
        }


        private function buildURL(term:String,lat:Number,lon:Number):String{
            var url:String = this.cfm + "srchString=" + term + "&latitude=" + lat.toString() + "&longitude=" + lon.toString();
            return url;
        }
    }
}