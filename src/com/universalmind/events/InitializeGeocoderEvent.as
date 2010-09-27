package com.universalmind.events {
import flash.events.Event;

import org.swizframework.utils.chain.EventChainStep;

    public class InitializeGeocoderEvent extends EventChainStep {

        public static const INITIALIZE:String = "com.universalmind.events.InitializeGeocoderEvent.INITIALIZE";

        public function InitializeGeocoderEvent(type:String) {
            super(type,true,true);
        }

        override public function clone():Event{
            return new InitializeGeocoderEvent(this.type);
        }
    }
}