package com.julianpagano.edhpods.service.impl;

import java.util.Collections;
import java.util.List;

import com.julianpagano.edhpods.service.inter.PodsGenerator;

public class NormalPodsGenerator implements PodsGenerator {

	public String[][] createPods(List<String> playersList) {

		Collections.shuffle(playersList);

		int numOfPlayers = playersList.size();
		int numOfTables = (int) Math.ceil(numOfPlayers / 4);

		String[][] pods = new String[numOfTables][4];

		int table = 0, spot = 0;
		for (int i = 0; i < numOfPlayers; i++) {

			pods[table][spot] = playersList.get(i);

			if (table < numOfTables) {
				table++;
			}
			else {
				table = 0;
				spot++;
			}
		}

		return pods;
	}

}