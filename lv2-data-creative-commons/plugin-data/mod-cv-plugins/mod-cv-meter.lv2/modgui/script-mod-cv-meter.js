function (event) {

	function highlight (c) {
		var dpm = event.icon.find ('[mod-role=dpm]');
		var old = dpm.data ('xBgColor');
		if (old == c) {
			return;
		}
		switch (c) {
			case 4:
				dpm.css({backgroundColor: '#ff4400'});
				break;
			case 3:
				dpm.css({backgroundColor: '#dd6622'});
				break;
			case 2:
				dpm.css({backgroundColor: '#ccaa66'});
				break;
			case 1:
				dpm.css({backgroundColor: '#88ff66'});
				break;
			default:
				dpm.css({backgroundColor: '#aacc66'});
				break;
		}
		dpm.data ('xBgColor', c);
	}

	function handle_event (symbol, value) {
		switch (symbol) {
			case 'min_level':
				var min_level = value;
				event.icon.find ('[mod-role=min_level]').text (min_level);
				break;
			case 'max_level':
				var max_level = value;
				event.icon.find ('[mod-role=max_level]').text (max_level);
				break;
			case 'level':
				var current_level = value;
				event.icon.find ('[mod-role=current_level]').text (current_level);
				break;
			default:
				break;
		}
	}

	if (event.type == 'start') {
		var dpm = event.icon.find ('[mod-role=dpm]');
		dpm.data ('xBgColor', 0);
		var ports = event.ports;
		for (var p in ports) {
			handle_event (ports[p].symbol, ports[p].value);
		}
	}
	else if (event.type == 'change') {
		handle_event (event.symbol, event.value);
	}
}
