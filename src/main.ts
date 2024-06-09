import { RAW_JET } from "./util";

globalThis.update = () => {
	const players = tm.players.CurrentPlayers();

	for (const { playerId }  of players) {
		const structures = tm.players.GetPlayerStructuresInBuild(playerId);
		
		for (const structure of structures) {
			const blocks = structure.GetBlocks();

			for (const block of blocks) {
				const blockName = block.GetName();

				if (blockName === RAW_JET)
			}
		}
	}
}