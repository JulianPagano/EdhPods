package com.julianpagano.edhpods.controller;

import java.util.Arrays;

import com.julianpagano.edhpods.service.inter.PodsGenerator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	@Autowired
	PodsGenerator podGenerator;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		return "index";
	}

	@RequestMapping(value = "/createPods", method = RequestMethod.POST)
	@ResponseBody
	public String[][] createPods(@RequestParam(value="arrPlayers[]", required=false) String[] arrPlayers) {
		
		String[][] pods = podGenerator.createPods(Arrays.asList(arrPlayers));

		return pods;
	}

}