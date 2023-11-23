state("PathOfExile_x64") {}
startup {
    vars.zones_one = new Dictionary<string, bool> {
        { "狮眼守望", false },
        { "监狱大门", false },
        { "南部森林", false },
        { "瓦尔废墟", false },
        { "萨恩城废墟", false },
        { "激战广场", false },
        { "水道遗迹", false },
        { "奥瑞亚之道", false },
        { "教堂顶楼", false },
    };
    vars.zones_two = new Dictionary<string, bool> {
        { "狮眼守望", false },
        { "断桥营地", false },
        { "奇迹之墙", false },
        { "赤红通道", false },
        { "奥瑞亚港", false },
        { "END BOSS", false },
    };
    vars.part_two = false;
}

init {
  print("init");
  string logPath;
  logPath = ("E:\\PathOfExileCn\\POE\\logs\\Client.txt");
  // 修改此处为你 POE 国服客户端对应目录，注意 \ 是 2 个
  try { // Wipe the log file to clear out messages from last time
    FileStream fs = new FileStream(logPath, FileMode.Open, FileAccess.Write, FileShare.ReadWrite);
    fs.SetLength(0);
    fs.Close();
    print("file loaded");
  } catch {
      print("File doesn't exist");
  } // May fail if file doesn't exist.
  vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)); 
}

update {
  vars.line = vars.reader.ReadLine();
  if (vars.line == null) return false; // If no line was read, don't run any other blocks.
}

split {
    if (vars.line == null) return false;
    if(vars.line.Contains("所有抗性永久降低60%！")) return true;
    // 特殊处理终章 BOSS
    
    if(!vars.line.Contains("你已进入")) return false;
    var zone = vars.line.Split(new[] { "你已进入： " }, StringSplitOptions.None);
    zone = zone[1].Trim('。');
    if(!vars.part_two) {
        if(vars.zones_one.ContainsKey(zone) && vars.zones_one[zone] == false) {
            vars.zones_one[zone] = true;
            if(zone == "教堂顶楼") vars.part_two = true;
            return true;
        }
    }
    else {
        if(vars.zones_two.ContainsKey(zone) && vars.zones_two[zone] == false) {
            vars.zones_two[zone] = true;
            return true;
        }
    }
    return false;
}

exit {
    vars.reader = null;
}

onReset {
    vars.zones_one = new Dictionary<string, bool> {
        { "狮眼守望", false },
        { "监狱大门", false },
        { "南部森林", false },
        { "瓦尔废墟", false },
        { "萨恩城废墟", false },
        { "激战广场", false },
        { "水道遗迹", false },
        { "奥瑞亚之道", false },
        { "教堂顶楼", false },
    };
    vars.zones_two = new Dictionary<string, bool> {
        { "狮眼守望", false },
        { "断桥营地", false },
        { "奇迹之墙", false },
        { "赤红通道", false },
        { "奥瑞亚港", false },
        { "END BOSS", false },
    };
}
