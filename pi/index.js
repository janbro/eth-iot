import express from 'express';
//import example from './examples/membership';

const PORT = 2020;

let app = new express();
app.set('port', PORT);

app = example(app);

app.listen(app.get('port), () => {
	console.log(`Pi-Node on port ${app.get('port')}`);
});
