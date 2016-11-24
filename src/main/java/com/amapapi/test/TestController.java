package com.amapapi.test;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;

/**
 * Created by Administrator on 2016/11/24.
 */

@Controller
@RequestMapping("lxx")
public class TestController {


    @RequestMapping("/hello")
    @ResponseBody
    public String hello() {
        return "hello";
    }
    @RequestMapping("/str")
    public String str(Model model) {
//        model.addAttribute("str","hello world");
        String s = "116.376414,39.937015;116.352038,39.934251;116.406283,39.927143;116.414866,39.958466";
        model.addAttribute("arrStr",s);
        return "test";
    }
    @RequestMapping("/edit")
    public String edit(Model model) {
        String s = "116.376414,39.937015;116.352038,39.934251;116.406283,39.927143;116.414866,39.958466";
        model.addAttribute("arrStr",s);
        return "edit2";
    }

    @RequestMapping("/getPerson")
    public void getPerson(String name,PrintWriter pw){
        System.out.println(name+"<<<< ");
        if (name != null && name.length() > 0) {
            StringBuilder builder = new StringBuilder();
            String s[] = name.split(",");
            for (int i = 0; i < s.length; i+=2) {
                builder.append(s[i]).append(",").append(s[i+1]).append(";");
            }
            builder.deleteCharAt(builder.length()-1);
            name = builder.toString();
        }
        System.out.println(">>>>>>"+name);
        pw.write("hello,"+name);
    }

}
