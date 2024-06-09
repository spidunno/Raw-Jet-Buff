import { Element, Input, Label, Layout } from "tm-ui-lib";
import { RAW_JET, DEFAULT_STRENGTH, TOGGLE_KEY } from "./util";

let strength = DEFAULT_STRENGTH;

let visible = true;

globalThis.update = () => {
	const players = tm.players.CurrentPlayers();

	for (const { playerId }  of players) {
		const structures = tm.players.GetPlayerStructuresInBuild(playerId);
		
		for (const structure of structures) {
			const blocks = structure.GetBlocks();

			for (const block of blocks) {
				const blockName = block.GetName();

				if (blockName.includes(RAW_JET)) {
					block.SetJetPower(strength);
				}
			}
		}
	}
}

const elements: Element[] = [
	new Label('RAW Jet strength (default 1500): '),
	new Input(strength.toString(), (data) => {
		const value = parseFloat(data.value);

		// from my experience Number.isNaN isn't functional
		if (value !== value) return;

		strength = value;
		(elements[1] as Input).content = strength.toString()
	}),
	new Label('--------------------------------------------------'),
	new Label(`   [Press ${TOGGLE_KEY.toUpperCase()} to toggle visibility]`),
];

const layout = new Layout(elements, [0]);

// ugh gotta make this better somehow, but it would be complicated.
//@ts-expect-error
globalThis.VisibilityToggleFunction = (playerId: PlayerID) => {
	visible = !visible;
	if (visible) {
		layout.items = elements;
	} else {
		layout.items = [];
	}
}

tm.players.onPlayerJoined.add((player) => {
	if (player.playerId !== 0) return;
	tm.input.RegisterFunctionToKeyDownCallback(0, 'VisibilityToggleFunction', TOGGLE_KEY);
});
