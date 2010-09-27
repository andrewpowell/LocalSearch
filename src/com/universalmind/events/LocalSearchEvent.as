package com.universalmind.events {
import flash.events.Event;

import org.swizframework.utils.chain.EventChainStep;

    public class LocalSearchEvent extends EventChainStep {

        public static const DO_SEARCH:String = "com.universalmind.events.LocalSearchEvent.DO_SEARCH";

        private var _term:String;

        public function LocalSearchEvent(type:String,term:String) {
            super(type,true,true);
            this._term=term;
        }

        public function get term():String {
            return _term;
        }

        public function set term(value:String):void {
            _term = value;
        }

        override public function clone():Event{
            return new LocalSearchEvent(this.type,this._term);
        }
    }
}