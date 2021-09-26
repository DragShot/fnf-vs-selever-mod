package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.addons.ui.FlxUIGroup;
using StringTools;

class CreditsState extends MusicBeatState {

    var entries:Array<Array<InfoEntry>>;
    var comps:Array<FlxUIGroup>;
    var layout:FlxUIGroup;
    var backspc:FlxSprite;

    var offsetTop:Int = 0;
    var offsetBottom:Int = 700;

    override function create() {
        this.clean();
        //Cargar datos de créditos
        var creditsData = CoolUtil.coolTextFile(Paths.txt("data/creditsData"));
        //trace("Credits file read");
        this.entries = [];
        var group:Array<InfoEntry> = [];
        for (i in 0...creditsData.length) {
            var data:Array<String> = creditsData[i].trim().split("|");
            if (data.length == 0) continue;
            var text = data[0].trim();
            if (text == "#offsets" && data.length >= 3) {
                this.offsetTop = this.nvl(Std.parseInt(data[1]), this.offsetTop);
                this.offsetBottom = this.nvl(Std.parseInt(data[2]), this.offsetBottom);
                continue;
            }
            if (text.startsWith("[") && text.endsWith("]")) {
                if (group.length > 0) {
                    entries.push(group);
                    group = [];
                }
                text = text.substring(1, text.length - 1);
                group.push(new InfoEntry(text));
                continue;
            }
            var icon = this.readParam(data, 1);
            var descr = this.readParam(data, 2);
            var textbold = this.readParam(data, 3);
            if (textbold == null) {
                group.push(new InfoEntry(text, icon, descr));
            } else {
                group.push(new InfoEntry(text, icon, descr, textbold == '1'));
            }
        }
        if (group.length > 0) entries.push(group);
        //trace("Credits data loaded");
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = FlxG.save.data.antialiasing;
        bg.color = 0x99ffaa;
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
        //trace("Init background");
        //Crear elementos de la interfaz
        //var px:Float = -460;
        //var py:Float = -10;
        comps = [];
        layout = new FlxUIGroup(-480, this.offsetTop);
        var py:Float = 0;
        for (i in 0...entries.length) {
            for (j in 0...entries[i].length) {
                //trace("* Group");
                var entry:InfoEntry = entries[i][j];
                var group = new FlxUIGroup(j == 0 ? 0 : 60, py);
                var textComp = new Alphabet(0, 0, entry.text, entry.textbold);
                textComp.updateHitbox();
                group.add(textComp);
                //trace(" -> Text (" + textComp.x + ", " + textComp.y + ", " + textComp.width + ", " + textComp.height + ") : " + entry.text);
                if (entry.icon != null) {
                    var iconComp;
                    //FileSystem.exists(Paths.image('icons/icon-' + char));
                    iconComp = new HealthIcon(entry.icon);
                    iconComp.sprTracker = textComp;
                    iconComp.updateHitbox();
                    group.add(iconComp);
                    //trace(" -> Icon (" + iconComp.x + ", " + iconComp.y + ", " + iconComp.width + ", " + iconComp.height + ")");
                }
                //This is always needed for some reason...
                var descComp = new FlxText(0, textComp.height + 5, FlxG.width * 0.8, this.nvl(entry.descr, " "));
                descComp.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                descComp.updateHitbox();
                group.add(descComp);
                //trace(" -> Description (" + descComp.x + ", " + descComp.y + ", " + descComp.width + ", " + descComp.height + ")");
                //trace("   Group");
                group.updateHitbox();//calcBounds();
                comps.push(group);
                layout.add(group);
                py += group.height + 10;
                //trace("<- Group (" + group.x + ", " + group.y + ", " + group.width + ", " + group.height + ")");
            }
            py += 10;
        }
        layout.updateHitbox();
        this.add(layout);
        //trace("<- Layout (" + layout.x + ", " + layout.y + ", " + layout.width + ", " + layout.height + ")");
        this.backspc = new FlxSprite();
        backspc.frames = Paths.getSparrowAtlas('backspace');
        backspc.animation.addByIndices('idle', "backspace to exit", [0], "", 24);
        backspc.animation.addByPrefix('pressed', "backspace PRESSED", 24);
        backspc.animation.play('idle');
		backspc.antialiasing = FlxG.save.data.antialiasing;
		backspc.updateHitbox();
        backspc.setPosition(FlxG.width - 20 - backspc.width, FlxG.height - 20 - backspc.height);
		add(backspc);

        super.create();
    }

    private function nvl(value:Any, nullValue) {
        return value == null ? nullValue : value;
    }
	
    private var scrolling = false;

	override function update(elapsed:Float) {
		super.update(elapsed);
        var up = FlxG.keys.justPressed.UP;
		var down = FlxG.keys.justPressed.DOWN;
		var accepted = FlxG.keys.justPressed.ENTER;
        if (up) {
            if (!scrolling && layout.y < this.offsetTop) {
                this.lockScrolling();
                FlxTween.tween(layout, {y: layout.y + 200}, 0.15, {ease: FlxEase.quadOut, onComplete: this.unlockScrolling});
                //for (item in comps)
                    //FlxTween.tween(item, {y: item.y + 100}, 0.15, {ease: FlxEase.quadOut, onComplete: this.unlockScrolling}); //item.y += 100;
            }
        } else if (down) {
            //var comp = comps[comps.length - 1];
            if (!scrolling && layout.y + layout.height > this.offsetBottom) {
                this.lockScrolling();
                FlxTween.tween(layout, {y: layout.y - 200}, 0.15, {ease: FlxEase.quadOut, onComplete: this.unlockScrolling});
                //for (item in comps)
                //    FlxTween.tween(item, {y: item.y - 100}, 0.15, {ease: FlxEase.quadOut, onComplete: this.unlockScrolling}); //item.y -= 100;
            }
        }
        if (controls.BACK || accepted) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            //backspc.animation.play('pressed');
            FlxG.switchState(new MainMenuState());
        }
    }

    function lockScrolling() {
        this.scrolling = true;
        FlxG.sound.play(Paths.sound('scrollMenu'));
    }

    function unlockScrolling(tween:FlxTween) {
        this.scrolling = false;
    }

    private function readParam(array:Array<String>, index:Int):String {
        var param = null;
        if (array.length > index) {
            param = array[index].trim();
            if (param == '' || param == '-') param = null;
        }
        return param;
    }
}

class InfoEntry {
    public var text:String;
    public var icon:String;
    public var descr:String;
    public var textbold:Bool;

    public function new(text:String, ?icon:String = null, ?descr:String = null, ?textbold:Bool = true) {
        this.text = text;
        this.icon = icon;
        this.descr = descr;
        this.textbold = textbold;
    }
}