
const {{name}}Config: SmartMirror.IWidgetConfig = {
	name: '{{nickname}}',
	icon: 'fad fa-align-justify',
	helper: true,
	link: "your_url_link",
	author: "your_name_here",
	version: "0.0.1",
	settings: [{
		name: "title",
		displayOnly: true,
		label: "Label",
		order: 1,
		type: 'text',
		description: "{{name}} description"
	}, {
		name: "header",
		label: "Widget Title",
		type: 'input',
		value: "{{name}}",
		description: "The header title of the widget."
	}]
}

module.exports = {{name}}Config;