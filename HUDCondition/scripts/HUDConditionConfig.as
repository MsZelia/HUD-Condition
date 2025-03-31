package
{
   import flash.utils.ByteArray;
   import utils.Parser;
   
   public class HUDConditionConfig
   {
      
      public static const STATE_HIDDEN:String = "hidden";
      
      public static const STATE_SHOWN:String = "shown";
      
      private static const TEXTURES_LOCATION:String = "Textures/HUDCondition/";
      
      private static const PARTS:Array = ["LeftArm","RightArm","LeftLeg","RightLeg","Chest","Hat"];
      
      private static const DEFAULT_PARTS:Object = {
         "disable":false,
         "Hat":{
            "text":["helmet","hat"],
            "image":TEXTURES_LOCATION + "Hat/White.dds",
            "gradients":[{
               "belowPercent":5,
               "image":TEXTURES_LOCATION + "Hat/Red.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":20,
               "image":TEXTURES_LOCATION + "Hat/Red.dds",
               "hue":20,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":35,
               "image":TEXTURES_LOCATION + "Hat/Yellow.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":100,
               "image":TEXTURES_LOCATION + "Hat/White.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":160,
               "image":TEXTURES_LOCATION + "Hat/Green.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":300,
               "image":TEXTURES_LOCATION + "Hat/Teal.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            }],
            "offsetText":{
               "x":64,
               "y":-10
            },
            "offsetImage":{
               "x":50,
               "y":0
            },
            "scaleImage":{
               "x":1,
               "y":1
            },
            "showPercentage":true
         },
         "RightArm":{
            "text":["right arm"," ra "],
            "image":TEXTURES_LOCATION + "RightArm/White.dds",
            "gradients":[{
               "belowPercent":5,
               "image":TEXTURES_LOCATION + "RightArm/Red.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":20,
               "image":TEXTURES_LOCATION + "RightArm/Red.dds",
               "hue":20,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":35,
               "image":TEXTURES_LOCATION + "RightArm/Yellow.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":100,
               "image":TEXTURES_LOCATION + "RightArm/White.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":160,
               "image":TEXTURES_LOCATION + "RightArm/Green.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":300,
               "image":TEXTURES_LOCATION + "RightArm/Teal.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            }],
            "offsetText":{
               "x":15,
               "y":35
            },
            "offsetImage":{
               "x":25,
               "y":30
            },
            "scaleImage":{
               "x":1,
               "y":1
            },
            "showPercentage":true
         },
         "LeftArm":{
            "text":["left arm"," la "],
            "image":TEXTURES_LOCATION + "LeftArm/White.dds",
            "gradients":[{
               "belowPercent":5,
               "image":TEXTURES_LOCATION + "LeftArm/Red.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":20,
               "image":TEXTURES_LOCATION + "LeftArm/Red.dds",
               "hue":20,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":35,
               "image":TEXTURES_LOCATION + "LeftArm/Yellow.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":100,
               "image":TEXTURES_LOCATION + "LeftArm/White.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":160,
               "image":TEXTURES_LOCATION + "LeftArm/Green.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":300,
               "image":TEXTURES_LOCATION + "LeftArm/Teal.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            }],
            "offsetText":{
               "x":105,
               "y":35
            },
            "offsetImage":{
               "x":77,
               "y":33
            },
            "scaleImage":{
               "x":1,
               "y":1
            },
            "showPercentage":true
         },
         "RightLeg":{
            "text":["right leg"," rl "],
            "image":TEXTURES_LOCATION + "RightLeg/White.dds",
            "gradients":[{
               "belowPercent":5,
               "image":TEXTURES_LOCATION + "RightLeg/Red.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":20,
               "image":TEXTURES_LOCATION + "RightLeg/Red.dds",
               "hue":20,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":35,
               "image":TEXTURES_LOCATION + "RightLeg/Yellow.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":100,
               "image":TEXTURES_LOCATION + "RightLeg/White.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":160,
               "image":TEXTURES_LOCATION + "RightLeg/Green.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":300,
               "image":TEXTURES_LOCATION + "RightLeg/Teal.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            }],
            "offsetText":{
               "x":20,
               "y":95
            },
            "offsetImage":{
               "x":39,
               "y":77
            },
            "scaleImage":{
               "x":1,
               "y":1
            },
            "showPercentage":true
         },
         "LeftLeg":{
            "text":["left leg"," ll "],
            "image":TEXTURES_LOCATION + "LeftLeg/White.dds",
            "gradients":[{
               "belowPercent":5,
               "image":TEXTURES_LOCATION + "LeftLeg/Red.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":20,
               "image":TEXTURES_LOCATION + "LeftLeg/Red.dds",
               "hue":20,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":35,
               "image":TEXTURES_LOCATION + "LeftLeg/Yellow.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":100,
               "image":TEXTURES_LOCATION + "LeftLeg/White.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":160,
               "image":TEXTURES_LOCATION + "LeftLeg/Green.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":300,
               "image":TEXTURES_LOCATION + "LeftLeg/Teal.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            }],
            "offsetText":{
               "x":110,
               "y":95
            },
            "offsetImage":{
               "x":61,
               "y":80
            },
            "scaleImage":{
               "x":1,
               "y":1
            },
            "showPercentage":true
         },
         "Chest":{
            "text":["chest","torso"," ch "],
            "image":TEXTURES_LOCATION + "Chest/White.dds",
            "gradients":[{
               "belowPercent":5,
               "image":TEXTURES_LOCATION + "Chest/Red.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":20,
               "image":TEXTURES_LOCATION + "Chest/Red.dds",
               "hue":20,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":35,
               "image":TEXTURES_LOCATION + "Chest/Yellow.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":100,
               "image":TEXTURES_LOCATION + "Chest/White.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":160,
               "image":TEXTURES_LOCATION + "Chest/Green.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            },{
               "belowPercent":300,
               "image":TEXTURES_LOCATION + "Chest/Teal.dds",
               "hue":0,
               "saturation":0,
               "brightness":0,
               "contrast":0
            }],
            "offsetText":{
               "x":60,
               "y":130
            },
            "offsetImage":{
               "x":49,
               "y":44
            },
            "scaleImage":{
               "x":1,
               "y":1
            },
            "showPercentage":true
         }
      };
      
      private static var _config:Object;
       
      
      public function HUDConditionConfig()
      {
         super();
      }
      
      public static function get() : Object
      {
         return _config;
      }
      
      public static function init(jsonObject:*) : Object
      {
         var config:*;
         var cg:int;
         var p:int;
         var g:int;
         var img:String;
         var belowPercent:Number;
         var errorCode:String = "";
         try
         {
            config = jsonObject;
            config.x = Parser.parseNumber(config.x,50);
            config.y = Parser.parseNumber(config.y,50);
            config.width = 250;
            config.textSize = Parser.parseNumber(config.textSize,18);
            config.textFont = Boolean(config.textFont) ? config.textFont : "$MAIN_Font";
            config.textAlign = Boolean(config.textAlign) ? config.textAlign.toLowerCase() : "left";
            config.textColor = Parser.parseNumber(config.textColor,16777215);
            config.textShadow = Parser.parseBoolean(config.textShadow,true);
            config.alpha = Parser.parseNumber(config.alpha,1);
            config.blendMode = Boolean(config.blendMode) ? config.blendMode.toLowerCase() : "normal";
            config.textBlendMode = Boolean(config.textBlendMode) ? config.textBlendMode.toLowerCase() : "normal";
            config.instantConfigReload = Boolean(config.instantConfigReload);
            config.refresh = Parser.parseNumber(config.refresh,100);
            config.percentDecimals = Parser.parseNumber(config.percentDecimals,0);
            errorCode = "textsScale";
            config.textsScale = parsePoint(config.textsScale,1,1);
            errorCode = "imagesScale";
            config.imagesScale = parsePoint(config.imagesScale,1,1);
            errorCode = "TextColorGradients";
            config.useTextColorGradients = Parser.parseBoolean(config.useTextColorGradients,true);
            if(config.textColorGradients != null)
            {
               cg = 0;
               while(cg < config.textColorGradients.length)
               {
                  config.textColorGradients[cg].belowPercent = Parser.parseNumber(config.textColorGradients[cg].belowPercent,-1);
                  config.textColorGradients[cg].color = Parser.parseNumber(config.textColorGradients[cg].color,config.textColor);
                  cg++;
               }
            }
            else
            {
               config.textColorGradients = [{
                  "belowPercent":5,
                  "color":"0xff0000"
               },{
                  "belowPercent":20,
                  "color":"0xe8460c"
               },{
                  "belowPercent":35,
                  "color":"0xffff55"
               },{
                  "belowPercent":100,
                  "color":"0xffffff"
               },{
                  "belowPercent":160,
                  "color":"0xaaffaa"
               },{
                  "belowPercent":300,
                  "color":"0xaaffff"
               }];
            }
            errorCode = "BackgroundImage";
            if(config.BackgroundImage != null)
            {
               config.BackgroundImage.disable = Boolean(config.BackgroundImage.disable);
               errorCode = "BackgroundImage.image";
               config.BackgroundImage.image = getImageDir(config.BackgroundImage.image,"Underarmor/VaultBoy/White.dds");
               errorCode = "BackgroundImage.offset";
               config.BackgroundImage.offset = parsePoint(config.BackgroundImage.offset,13,4);
               errorCode = "BackgroundImage.scale";
               config.BackgroundImage.scale = parsePoint(config.BackgroundImage.scale,0.56,0.56);
               errorCode = "BackgroundImage.adjustColor";
               config.BackgroundImage.adjustColor = Boolean(config.BackgroundImage.adjustColor);
               errorCode = "BackgroundImage.color";
               config.BackgroundImage.color = parseHSBColor(config.BackgroundImage.color,0,0,0,0);
            }
            else
            {
               config.BackgroundImage = {
                  "image":TEXTURES_LOCATION + "Underarmor/VaultBoy/White.dds",
                  "offset":{
                     "x":13,
                     "y":4
                  },
                  "scale":{
                     "x":0.56,
                     "y":0.56
                  },
                  "adjustColor":false,
                  "color":{
                     "hue":0,
                     "saturation":0,
                     "brightness":0,
                     "contrast":0
                  }
               };
            }
            errorCode = "Weapon";
            if(config.Weapon != null)
            {
               config.Weapon.showCondition = Boolean(config.Weapon.showCondition);
               config.Weapon.offsetText = parsePoint(config.Weapon.offsetText,0,155);
               config.Weapon.textLength = Parser.parseNumber(config.Weapon.textLength,15);
            }
            else
            {
               config.Weapon = {"showCondition":false};
            }
            errorCode = "Parts";
            if(config.Parts != null)
            {
               config.Parts.disable = Boolean(config.Parts.disable);
               p = 0;
               while(p < PARTS.length)
               {
                  if(config.Parts[PARTS[p]] != null)
                  {
                     config.Parts[PARTS[p]].text = parseArray(config.Parts[PARTS[p]].text,DEFAULT_PARTS[PARTS[p]].text);
                     config.Parts[PARTS[p]].image = getImageDir(config.Parts[PARTS[p]].image,PARTS[p] + "/White.dds");
                     config.Parts[PARTS[p]].gradients = parseArray(config.Parts[PARTS[p]].gradients,DEFAULT_PARTS[PARTS[p]].gradients);
                     config.Parts[PARTS[p]].offsetText = parsePoint(config.Parts[PARTS[p]].offsetText,DEFAULT_PARTS[PARTS[p]].offsetText.x,DEFAULT_PARTS[PARTS[p]].offsetText.y);
                     config.Parts[PARTS[p]].offsetImage = parsePoint(config.Parts[PARTS[p]].offsetImage,DEFAULT_PARTS[PARTS[p]].offsetImage.x,DEFAULT_PARTS[PARTS[p]].offsetImage.y);
                     config.Parts[PARTS[p]].scaleImage = parsePoint(config.Parts[PARTS[p]].scaleImage,1,1);
                     config.Parts[PARTS[p]].showPercentage = Boolean(config.Parts[PARTS[p]].showPercentage);
                     g = 0;
                     while(g < config.Parts[PARTS[p]].gradients.length)
                     {
                        img = getImageDir(config.Parts[PARTS[p]].gradients[g].image,PARTS[p] + "/White.dds");
                        belowPercent = Parser.parseNumber(config.Parts[PARTS[p]].gradients[g].belowPercent,-1);
                        config.Parts[PARTS[p]].gradients[g] = parseHSBColor(config.Parts[PARTS[p]].gradients[g],0,0,0,0);
                        config.Parts[PARTS[p]].gradients[g].belowPercent = belowPercent;
                        config.Parts[PARTS[p]].gradients[g].image = img;
                        g++;
                     }
                  }
                  else
                  {
                     config.Parts[PARTS[p]] = clone(DEFAULT_PARTS[PARTS[p]]);
                  }
                  p++;
               }
            }
            else
            {
               config.Parts = clone(DEFAULT_PARTS);
            }
            errorCode = "HUDModesState";
            config.HUDModesState = getState(config.HUDModesState);
            if(!config.HUDModes)
            {
               config.HUDModes = [];
            }
            _config = config;
            return _config;
         }
         catch(e:Error)
         {
            throw new Error("@" + errorCode + " - " + e);
         }
      }
      
      private static function clone(source:Object) : *
      {
         var myBA:ByteArray = new ByteArray();
         myBA.writeObject(source);
         myBA.position = 0;
         return myBA.readObject();
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
            "x":Parser.parseNumber(obj.x,dX),
            "y":Parser.parseNumber(obj.y,dY)
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
         obj.hue = Parser.parseNumber(obj.hue,defH);
         obj.saturation = Parser.parseNumber(obj.saturation,defS);
         obj.brightness = Parser.parseNumber(obj.brightness,defB);
         obj.contrast = Parser.parseNumber(obj.contrast,defC);
         return obj;
      }
      
      private static function getImageDir(data:Object, defaultValue:String) : String
      {
         var value:String = "";
         if(data != null && data.length > 4)
         {
            value = data;
         }
         else
         {
            value = defaultValue;
         }
         if(value.indexOf(TEXTURES_LOCATION) == -1)
         {
            value = TEXTURES_LOCATION + value;
         }
         return value;
      }
      
      public static function parseArray(obj:Object, def:Object) : Array
      {
         if(obj == null)
         {
            return [].concat(def);
         }
         return [].concat(obj);
      }
      
      private static function getState(data:Object) : String
      {
         if(!data)
         {
            return STATE_HIDDEN;
         }
         if(data.toLowerCase() == STATE_SHOWN)
         {
            return STATE_SHOWN;
         }
         return STATE_HIDDEN;
      }
   }
}
