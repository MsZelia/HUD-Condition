package
{
   import Shared.*;
   import Shared.AS3.*;
   import Shared.AS3.Data.*;
   import Shared.AS3.Events.*;
   import com.adobe.serialization.json.*;
   import fl.motion.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import scaleform.gfx.*;
   import utils.*;
   
   public class HUDCondition extends MovieClip
   {
      
      public static const MOD_NAME:String = "HUDCondition";
      
      public static const MOD_VERSION:String = "1.0.3";
      
      public static const FULL_MOD_NAME:String = MOD_NAME + " " + MOD_VERSION;
      
      public static const CONFIG_FILE:String = "../HUDCondition.json";
      
      public static const CONFIG_RELOAD_TIME:uint = 975;
      
      private static const TITLE_HUDMENU:String = "HUDMenu";
       
      
      private const PARTS:Array = ["LeftArm","RightArm","LeftLeg","RightLeg","Chest","Hat"];
      
      private var TEXTFIELDS:Array;
      
      private var TEXTURES:Array;
      
      private var MATRIX:Array;
      
      private var configReloadIndex:int = 0;
      
      private var lastConfigUpdateTime:Number = 0;
      
      private var lastRenderTime:Number = 0;
      
      private var topLevel:* = null;
      
      private var dummy_tf:TextField;
      
      private var textFormat:TextFormat;
      
      private var configTimer:Timer;
      
      private var displayTimer:Timer;
      
      private var lastConfig:String;
      
      private var HUDModeData:*;
      
      private var CharacterInfoData:*;
      
      public var inPowerArmor:Boolean = false;
      
      private var conditions_tf:Array;
      
      private var conditions_index:int = 0;
      
      private var lastConditionsTime:Number = 0;
      
      public var conditions:Array;
      
      public var Base_mc:MovieClip;
      
      public var TextureBase_mc:MovieClip;
      
      public var TextureLoader:ImageFixture;
      
      public var LA_mc:ImageFixture;
      
      public var RA_mc:ImageFixture;
      
      public var LL_mc:ImageFixture;
      
      public var RL_mc:ImageFixture;
      
      public var CH_mc:ImageFixture;
      
      public var HA_mc:ImageFixture;
      
      public var LA_tf:TextField;
      
      public var RA_tf:TextField;
      
      public var LL_tf:TextField;
      
      public var RL_tf:TextField;
      
      public var CH_tf:TextField;
      
      public var HA_tf:TextField;
      
      public var WEAPON_tf:TextField;
      
      public function HUDCondition()
      {
         this.conditions = [];
         this.conditions_tf = [];
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         this.HUDModeData = BSUIDataManager.GetDataFromClient("HUDModeData");
         this.CharacterInfoData = BSUIDataManager.GetDataFromClient("CharacterInfoData");
         this.configTimer = new Timer(CONFIG_RELOAD_TIME);
         this.configTimer.addEventListener(TimerEvent.TIMER,this.loadConfig);
         this.configTimer.start();
         this.init();
      }
      
      public static function toString(param1:Object) : String
      {
         return new JSONEncoder(param1).getString();
      }
      
      public static function ShowHUDMessage(param1:String) : void
      {
         GlobalFunc.ShowHUDMessage("[" + FULL_MOD_NAME + "] " + param1);
      }
      
      public static function FormatTimeStringShort(param1:Number) : String
      {
         var remainingTime:Number = 0;
         var nDays:Number = Math.floor(param1 / 86400);
         remainingTime = param1 % 86400;
         var nHours:Number = Math.floor(remainingTime / 3600);
         remainingTime = param1 % 3600;
         var nMinutes:Number = Math.floor(remainingTime / 60);
         var isSet:Boolean = false;
         var timeString:* = "";
         if(nDays > 0)
         {
            timeString = GlobalFunc.PadNumber(nDays,2);
            isSet = true;
         }
         if(nDays > 0 || nHours > 0)
         {
            if(isSet)
            {
               timeString += ":";
            }
            else
            {
               isSet = true;
            }
            timeString += GlobalFunc.PadNumber(nHours,2);
         }
         if(nDays > 0 || nHours > 0 || nMinutes > 0)
         {
            if(isSet)
            {
               timeString += ":";
            }
            else
            {
               isSet = true;
            }
            timeString += GlobalFunc.PadNumber(nMinutes,2);
         }
         return timeString;
      }
      
      public static function RgbToHsv(rgb:Number) : Object
      {
         var red:Number = rgb >> 16;
         var grn:Number = rgb >> 8 & 0xFF;
         var blu:Number = rgb & 0xFF;
         red /= 255;
         grn /= 255;
         blu /= 255;
         var x:Number = Math.min(Math.min(red,grn),blu);
         var val:Number = Math.max(Math.min(red,grn),blu);
         if(x == val)
         {
            return {
               "h":0,
               "s":0,
               "v":val * 100
            };
         }
         var f:Number = red == x ? grn - blu : (grn == x ? blu - red : red - grn);
         var i:Number = red == x ? 3 : (grn == x ? 5 : 1);
         var hue:Number = Math.floor((i - f / (val - x)) * 60) % 360;
         var sat:Number = Math.floor((val - x) / val * 100);
         val = Math.floor(val * 100);
         return {
            "h":hue,
            "s":sat,
            "v":val
         };
      }
      
      public function addedToStageHandler(param1:Event) : *
      {
         this.topLevel = stage.getChildAt(0);
         if(Boolean(this.topLevel))
         {
            if(getQualifiedClassName(this.topLevel) == TITLE_HUDMENU)
            {
               BSUIDataManager.Subscribe("PlayerInventoryData",this.updateConditions);
            }
            trace(MOD_NAME + " added to stage: " + getQualifiedClassName(this.topLevel));
         }
         else
         {
            trace(MOD_NAME + " not added to stage: " + getQualifiedClassName(this.topLevel));
            ShowHUDMessage("Not added to stage: " + getQualifiedClassName(this.topLevel));
         }
      }
      
      public function isHUDModeDataChanged() : void
      {
         if(config && config.useDynamicPowerArmorParts && this.inPowerArmor != this.HUDModeData.data.inPowerArmor)
         {
            this.inPowerArmor = this.HUDModeData.data.inPowerArmor;
            initPartsConfig();
            loadTextures();
         }
      }
      
      public function updateConditions(event:*) : void
      {
         var data:* = event.data;
         if(data != null && data.InventoryList != null)
         {
            var t1:Number = Number(getTimer());
            var len:int = int(data.InventoryList.length);
            var _conditions:Array = [];
            var i:int = 0;
            while(i < len)
            {
               if(data.InventoryList[i].equipState == 1 && data.InventoryList[i].durability > 0)
               {
                  _conditions.push({
                     "text":data.InventoryList[i].text,
                     "filterFlag":data.InventoryList[i].filterFlag,
                     "percentHealth":100 * data.InventoryList[i].currentHealth / data.InventoryList[i].maximumHealth
                  });
               }
               i++;
            }
            this.conditions = _conditions;
            this.lastConditionsTime = getTimer() - t1;
         }
      }
      
      public function loadConfig() : void
      {
         var loaderComplete:Function;
         var url:URLRequest = null;
         var loader:URLLoader = null;
         try
         {
            configReloadIndex++;
            if(config != null)
            {
               if(config.disableRealTimeEdit)
               {
                  return;
               }
               if(!config.instantConfigReload && configReloadIndex % 10 != 0)
               {
                  return;
               }
            }
            loaderComplete = function(param1:Event):void
            {
               var jsonData:Object;
               var errorCode:String;
               try
               {
                  if(lastConfig != loader.data)
                  {
                     errorCode = "JSONDecoder";
                     jsonData = new JSONDecoder(loader.data,true).getValue();
                     errorCode = "ConfigInit";
                     HUDConditionConfig.init(jsonData);
                     errorCode = "initMovieClips";
                     initMovieClips();
                     errorCode = "initDisplayTimers";
                     initDisplayTimers();
                     errorCode = "initPartsConfig";
                     initPartsConfig();
                     errorCode = "loadTextures";
                     loadTextures();
                     errorCode = "lastConfig";
                     lastConfig = loader.data;
                     lastConfigUpdateTime = getTimer();
                  }
               }
               catch(e:Error)
               {
                  ShowHUDMessage("Error parsing config (" + errorCode + "): " + e);
               }
            };
            url = new URLRequest(CONFIG_FILE);
            loader = new URLLoader();
            loader.load(url);
            loader.addEventListener(Event.COMPLETE,loaderComplete);
         }
         catch(e:Error)
         {
            ShowHUDMessage("Error loading config: " + e);
         }
      }
      
      private function init() : void
      {
         MATRIX = [{
            "hue":0,
            "saturation":0,
            "brightness":0,
            "contrast":0
         },{
            "hue":0,
            "saturation":0,
            "brightness":0,
            "contrast":0
         },{
            "hue":0,
            "saturation":0,
            "brightness":0,
            "contrast":0
         },{
            "hue":0,
            "saturation":0,
            "brightness":0,
            "contrast":0
         },{
            "hue":0,
            "saturation":0,
            "brightness":0,
            "contrast":0
         },{
            "hue":0,
            "saturation":0,
            "brightness":0,
            "contrast":0
         }];
         this.TextureBase_mc = new MovieClip();
         this.TextureLoader = new ImageFixture();
         this.LA_mc = new ImageFixture();
         this.RA_mc = new ImageFixture();
         this.LL_mc = new ImageFixture();
         this.RL_mc = new ImageFixture();
         this.CH_mc = new ImageFixture();
         this.HA_mc = new ImageFixture();
         this.TextureBase_mc.addChild(this.TextureLoader);
         this.TextureBase_mc.addChild(this.RA_mc);
         this.TextureBase_mc.addChild(this.RL_mc);
         this.TextureBase_mc.addChild(this.HA_mc);
         this.TextureBase_mc.addChild(this.CH_mc);
         this.TextureBase_mc.addChild(this.LA_mc);
         this.TextureBase_mc.addChild(this.LL_mc);
         addChild(this.TextureBase_mc);
         TEXTURES = [this.LA_mc,this.RA_mc,this.LL_mc,this.RL_mc,this.CH_mc,this.HA_mc];
         this.Base_mc = new MovieClip();
         this.LA_tf = new TextField();
         this.RA_tf = new TextField();
         this.LL_tf = new TextField();
         this.RL_tf = new TextField();
         this.CH_tf = new TextField();
         this.HA_tf = new TextField();
         this.WEAPON_tf = new TextField();
         this.LA_tf.text = "LA";
         this.RA_tf.text = "RA";
         this.LL_tf.text = "LL";
         this.RL_tf.text = "RL";
         this.CH_tf.text = "CH";
         this.HA_tf.text = "HA";
         this.WEAPON_tf.text = "WPN";
         this.Base_mc.addChild(this.LA_tf);
         this.Base_mc.addChild(this.RA_tf);
         this.Base_mc.addChild(this.LL_tf);
         this.Base_mc.addChild(this.RL_tf);
         this.Base_mc.addChild(this.CH_tf);
         this.Base_mc.addChild(this.HA_tf);
         this.Base_mc.addChild(this.WEAPON_tf);
         addChild(this.Base_mc);
         TEXTFIELDS = [this.LA_tf,this.RA_tf,this.LL_tf,this.RL_tf,this.CH_tf,this.HA_tf];
      }
      
      private function initPartsConfig() : void
      {
         var i:int = 0;
         var lparts:* = this.inPowerArmor ? config.PowerArmor_Parts : config.Parts;
         var lbgImage:* = this.inPowerArmor ? config.PowerArmor_BackgroundImage : config.BackgroundImage;
         while(i < PARTS.length)
         {
            applyConfig(TEXTFIELDS[i]);
            TEXTFIELDS[i].x = lparts[PARTS[i]].offsetText.x;
            TEXTFIELDS[i].y = lparts[PARTS[i]].offsetText.y;
            TEXTFIELDS[i].visible = lparts[PARTS[i]].showPercentage;
            TEXTURES[i].x = lparts[PARTS[i]].offsetImage.x;
            TEXTURES[i].y = lparts[PARTS[i]].offsetImage.y;
            TEXTURES[i].scaleX = lparts[PARTS[i]].scaleImage.x;
            TEXTURES[i].scaleY = lparts[PARTS[i]].scaleImage.y;
            TEXTURES[i].LoadExternal(lparts[PARTS[i]].image,GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
            TEXTURES[i].alpha = lparts[PARTS[i]].alpha;
            i++;
         }
         if(config.Weapon.showCondition)
         {
            applyConfig(this.WEAPON_tf);
            this.WEAPON_tf.x = config.Weapon.offsetText.x;
            this.WEAPON_tf.y = config.Weapon.offsetText.y;
         }
         this.TextureLoader.x = lbgImage.offset.x;
         this.TextureLoader.y = lbgImage.offset.y;
         this.TextureLoader.scaleX = lbgImage.scale.x;
         this.TextureLoader.scaleY = lbgImage.scale.y;
         this.TextureLoader.visible = !config.disableBackgroundImage;
      }
      
      private function initMovieClips() : void
      {
         this.dummy_tf = new TextField();
         this.formatMessage();
         this.Base_mc.x = config.x;
         this.Base_mc.y = config.y;
         this.Base_mc.scaleX = config.textsScale.x;
         this.Base_mc.scaleY = config.textsScale.y;
         this.TextureBase_mc.x = config.x;
         this.TextureBase_mc.y = config.y;
         this.TextureBase_mc.scaleX = config.imagesScale.x;
         this.TextureBase_mc.scaleY = config.imagesScale.y;
      }
      
      private function loadTextures() : void
      {
         if(!config.disableBackgroundImage)
         {
            var lbgImage:* = this.inPowerArmor ? config.PowerArmor_BackgroundImage : config.BackgroundImage;
            if(lbgImage.adjustColor)
            {
               applyColorMatrixFilter(this.TextureLoader,lbgImage.color);
            }
            else
            {
               this.TextureLoader.filters = [];
            }
            TextureLoader.LoadExternal(lbgImage.image,GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
            TextureLoader.alpha = lbgImage.alpha;
         }
         if(!config.disableParts)
         {
            var i:int = 0;
            var lparts:* = this.inPowerArmor ? config.PowerArmor_Parts : config.Parts;
            while(i < PARTS.length)
            {
               if(lparts[PARTS[i]].image != null && lparts[PARTS[i]].image.length > 4)
               {
                  TEXTURES[i].LoadExternal(lparts[PARTS[i]].image,GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
                  TEXTURES[i].alpha = lparts[PARTS[i]].alpha;
               }
               i++;
            }
         }
      }
      
      private function initDisplayTimers() : void
      {
         if(this.displayTimer)
         {
            this.displayTimer.removeEventListener(TimerEvent.TIMER,this.displayConditionLoop);
         }
         this.displayTimer = new Timer(config.refresh);
         this.displayTimer.addEventListener(TimerEvent.TIMER,this.displayConditionLoop);
         this.displayTimer.start();
      }
      
      public function get config() : Object
      {
         return HUDConditionConfig.get();
      }
      
      public function formatMessage() : void
      {
         this.dummy_tf.htmlText = MOD_VERSION;
         this.dummy_tf.x = config.x;
         this.dummy_tf.y = config.y;
         this.dummy_tf.width = config.width;
         this.dummy_tf.background = false;
         TextFieldEx.setTextAutoSize(this.dummy_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.dummy_tf.autoSize = TextFieldAutoSize.LEFT;
         this.dummy_tf.wordWrap = false;
         this.dummy_tf.multiline = true;
         this.dummy_tf.visible = true;
         this.textFormat = new TextFormat(config.textFont,config.textSize,config.textColor);
         this.textFormat.align = config.textAlign;
         this.dummy_tf.defaultTextFormat = this.textFormat;
         this.dummy_tf.setTextFormat(this.textFormat);
         this.dummy_tf.filters = [new DropShadowFilter(2,45,0,1,1,1,1,BitmapFilterQuality.HIGH)];
         this.alpha = config.alpha;
         this.blendMode = config.blendMode;
      }
      
      public function resetMessages() : void
      {
         this.conditions_index = 0;
         for each(condition_tf in conditions_tf)
         {
            if(condition_tf != null)
            {
               condition_tf.visible = false;
               condition_tf.defaultTextFormat = this.textFormat;
               condition_tf.setTextFormat(this.textFormat);
            }
         }
      }
      
      public function createTextfield() : TextField
      {
         tf = new TextField();
         tf.defaultTextFormat = this.textFormat;
         TextFieldEx.setTextAutoSize(tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         tf.setTextFormat(this.textFormat);
         return tf;
      }
      
      public function applyColorMatrixFilter(mc:MovieClip, cfg:Object) : void
      {
         var adjustColor:AdjustColor = new AdjustColor();
         adjustColor.hue = cfg.hue;
         adjustColor.saturation = cfg.saturation;
         adjustColor.brightness = cfg.brightness;
         adjustColor.contrast = cfg.contrast;
         var colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter(adjustColor.CalculateFinalFlatArray());
         mc.filters = [colorMatrixFilter];
      }
      
      public function applyConfig(tf:TextField) : void
      {
         tf.visible = true;
         tf.width = config.width;
         tf.height = this.dummy_tf.height;
         if(conditions_index == 0)
         {
            tf.y = 0;
         }
         else
         {
            tf.y = LastDisplayTextfield.y + LastDisplayTextfield.height;
         }
         tf.blendMode = config.textBlendMode;
         tf.filters = Boolean(config.textShadow) ? this.dummy_tf.filters : [];
         tf.defaultTextFormat = this.textFormat;
         TextFieldEx.setTextAutoSize(tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         tf.setTextFormat(this.textFormat);
      }
      
      public function displayMessage(text:String) : void
      {
         if(conditions_tf.length < conditions_index || conditions_tf[conditions_index] == null)
         {
            conditions_tf[conditions_index] = createTextfield();
            addChild(conditions_tf[conditions_index]);
         }
         applyConfig(conditions_tf[conditions_index]);
         conditions_tf[conditions_index].text = text;
         conditions_index++;
      }
      
      public function get LastDisplayTextfield() : TextField
      {
         if(conditions_index == 0)
         {
            return conditions_tf[conditions_index];
         }
         return conditions_tf[conditions_index - 1];
      }
      
      public function getCustomColor(name:String) : Number
      {
         if(config.customColors[name] != null)
         {
            return config.customColors[name];
         }
         return config.textColor;
      }
      
      public function applyColor(name:String) : Boolean
      {
         if(config.customColors[name] != null)
         {
            LastDisplayTextfield.textColor = config.customColors[name];
            return true;
         }
         return false;
      }
      
      public function applyConditionColor(tf:TextField, cnd:Number) : void
      {
         if(!config.useTextColorGradients)
         {
            return;
         }
         var isColorChanged:Boolean = false;
         var i:int = 0;
         while(i < config.textColorGradients.length)
         {
            if(cnd <= config.textColorGradients[i].belowPercent)
            {
               tf.textColor = config.textColorGradients[i].color;
               isColorChanged = true;
               break;
            }
            i++;
         }
         if(!isColorChanged)
         {
            tf.textColor = config.textColor;
         }
      }
      
      public function loadConditionalImage(partId:int, cnd:Number) : void
      {
         var partName:String = PARTS[partId];
         var isImageLoaded:Boolean = false;
         var lparts:* = this.inPowerArmor ? config.PowerArmor_Parts : config.Parts;
         var i:int = 0;
         while(i < lparts[partName].gradients.length)
         {
            var gradient:Object = lparts[partName].gradients[i];
            if(cnd <= gradient.belowPercent)
            {
               if(TEXTURES[partId].imagePath != gradient.image)
               {
                  TEXTURES[partId].LoadExternal(gradient.image,GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
               }
               if(MATRIX[partId].hue != gradient.hue || MATRIX[partId].saturation != gradient.saturation || MATRIX[partId].brightness != gradient.brightness || MATRIX[partId].contrast != gradient.contrast)
               {
                  MATRIX[partId].hue = gradient.hue;
                  MATRIX[partId].saturation = gradient.saturation;
                  MATRIX[partId].brightness = gradient.brightness;
                  MATRIX[partId].contrast = gradient.contrast;
                  applyColorMatrixFilter(TEXTURES[partId],MATRIX[partId]);
               }
               TEXTURES[partId].alpha = gradient.alpha;
               isImageLoaded = true;
               break;
            }
            i++;
         }
         if(!isImageLoaded && TEXTURES[partId].imagePath != lparts[partName].image)
         {
            TEXTURES[partId].LoadExternal(lparts[partName].image,GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
            TEXTURES[partId].alpha = lparts[partName].alpha;
         }
      }
      
      public function displayConditionLoop() : void
      {
         var t1:Number;
         var i:int;
         var j:int;
         var index:int;
         var len:int;
         var lparts:*;
         var foundParts:Array = new Array(PARTS.length);
         var foundWeapon:Boolean = false;
         try
         {
            t1 = Number(getTimer());
            this.visible = this.isValidHUDMode();
            if(!this.visible)
            {
               return;
            }
            this.isHUDModeDataChanged();
            this.resetMessages();
            lparts = this.inPowerArmor ? config.PowerArmor_Parts : config.Parts;
            if(this.conditions.length > 0)
            {
               foundPart = false;
               i = 0;
               while(i < this.conditions.length)
               {
                  if(this.conditions[i].filterFlag & 8 || this.conditions[i].filterFlag & 0x10)
                  {
                     if(!config.disableParts)
                     {
                        j = 0;
                        while(j < PARTS.length)
                        {
                           if(!foundParts[j])
                           {
                              index = int(ArrayUtils.indexOfCaseInsensitiveString(lparts[PARTS[j]].text,this.conditions[i].text));
                              if(index != -1)
                              {
                                 loadConditionalImage(j,this.conditions[i].percentHealth);
                                 if(TEXTFIELDS[j].visible)
                                 {
                                    TEXTFIELDS[j].text = this.conditions[i].percentHealth.toFixed(config.percentDecimals) + "%";
                                    applyConditionColor(TEXTFIELDS[j],this.conditions[i].percentHealth);
                                 }
                                 foundParts[j] = true;
                                 break;
                              }
                           }
                           j++;
                        }
                     }
                  }
                  else if(this.conditions[i].filterFlag & 4)
                  {
                     foundWeapon = true;
                     if(config.Weapon.showCondition)
                     {
                        this.WEAPON_tf.text = conditions[i].text.substr(0,config.Weapon.textLength) + "  " + this.conditions[i].percentHealth.toFixed(config.percentDecimals) + "%";
                        applyConditionColor(this.WEAPON_tf,this.conditions[i].percentHealth);
                     }
                     else
                     {
                        this.WEAPON_tf.text = "";
                     }
                  }
                  i++;
               }
               j = 0;
               while(j < PARTS.length)
               {
                  TEXTURES[j].visible = foundParts[j];
                  if(!foundParts[j])
                  {
                     TEXTFIELDS[j].text = "";
                  }
                  j++;
               }
               if(!foundWeapon)
               {
                  this.WEAPON_tf.text = "";
               }
            }
            if(config.metrics)
            {
               displayMessage(this.lastRenderTime + "/" + this.lastConditionsTime + " ms");
            }
            if(config.debug)
            {
               displayMessage(FULL_MOD_NAME);
               displayMessage("HUDMode: " + this.HUDModeData.data.hudMode);
               displayMessage("inPA: " + this.inPowerArmor);
               displayMessage("RenderTime: " + this.lastRenderTime + "/" + this.lastConditionsTime + " ms");
               displayMessage("ConfigUpdate: " + ((getTimer() - this.lastConfigUpdateTime) / 1000).toFixed(2) + "s ago");
               displayMessage("ConfigReloadIndex: " + this.configReloadIndex);
               if(this.conditions.length > 0)
               {
                  i = 0;
                  while(i < this.conditions.length)
                  {
                     displayMessage(this.conditions[i].text + " " + this.conditions[i].percentHealth.toFixed(1) + "%");
                     i++;
                  }
               }
               displayMessage(" ");
               displayMessage("bg: " + this.TextureLoader.bitmapInstance + " : " + this.TextureLoader.imagePath);
               i = 0;
               while(i < TEXTURES.length)
               {
                  displayMessage(PARTS[i] + " o:" + lparts[PARTS[i]].offsetImage.x + "," + lparts[PARTS[i]].offsetImage.y + " s:" + lparts[PARTS[i]].scaleImage.x + "," + lparts[PARTS[i]].scaleImage.y);
                  displayMessage(this.TEXTURES[i].bitmapInstance + " : " + this.TEXTURES[i].imagePath);
                  i++;
               }
            }
            this.lastRenderTime = getTimer() - t1;
         }
         catch(error:*)
         {
            displayMessage("Error displaying: " + error);
         }
      }
      
      public function isValidHUDMode() : Boolean
      {
         if(config)
         {
            if(config.HUDModesState == HUDConditionConfig.STATE_HIDDEN)
            {
               return config.HUDModes.indexOf(this.HUDModeData.data.hudMode) == -1;
            }
            return config.HUDModes.indexOf(this.HUDModeData.data.hudMode) != -1;
         }
         return true;
      }
   }
}
