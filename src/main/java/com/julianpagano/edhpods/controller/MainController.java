package com.julianpagano.edhpods.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
	public String[][] createPods(@RequestParam String strPlayers) {
		
		String[] playersArr = strPlayers.split(",");

		for (int i = 0; i < playersArr.length; i++) {
			playersArr[i] = playersArr[i].replace("\t", "").replace("\n", "").trim();
		}

		List<String> playersList = new ArrayList<String>(Arrays.asList(playersArr));
		
		String[][] pods = podGenerator.createPods(playersList);

		return pods;
	}

}