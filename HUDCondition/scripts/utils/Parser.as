package utils
{
   public class Parser
   {
      
      public function Parser()
      {
         super();
      }
      
      public static function parsePositiveNumber(obj:Object, defaultValue:Object = 0) : *
      {
         if(obj != null)
         {
            var value:* = Number(obj);
            if(!isNaN(value) && value > 0)
            {
               return value;
            }
         }
         return defaultValue;
      }
      
      public static function parseNumber(obj:Object, defaultValue:Object = 0) : *
      {
         if(obj != null)
         {
            var value:* = Number(obj);
            if(!isNaN(value))
            {
               return value;
            }
         }
         return defaultValue;
      }
      
      public static function parseHotkey(config:Object, defaultValue:Object) : *
      {
         if(config)
         {
            return parsePositiveNumber(config.hotkey,defaultValue);
         }
         return defaultValue;
      }
      
      public static function parseBoolean(obj:Object, defaultValue:Object = false) : *
      {
         if(obj != null)
         {
            return Boolean(obj);
         }
         return defaultValue;
      }
      
      public static function parsePoint(obj:Object, dX:Number, dY:Number) : Object
      {
         if(obj == null)
         {
            return {
               "x":dX,
               "y":dY
            };
         }
         return {
            "x":parseNumber(obj.x,dX),
            "y":parseNumber(obj.y,dY)
         };
      }
      
      public static function parseHSBColor(obj:Object, defH:Number, defS:Number, defB:Number, defC:Number) : Object
      {
         if(obj == null)
         {
            return {
               "hue":defH,
               "saturation":defS,
               "brightness":defB,
               "contrast":defC
            };
         }
         obj.hue = parseNumber(obj.hue,defH);
         obj.saturation = parseNumber(obj.saturation,defS);
         obj.brightness = parseNumber(obj.brightness,defB);
         obj.contrast = parseNumber(obj.contrast,defC);
         return obj;
      }
      
      public static function parseArray(obj:Object, def:Object) : Array
      {
         if(obj == null)
         {
            return [].concat(def);
         }
         return [].concat(obj);
      }
   }
}

