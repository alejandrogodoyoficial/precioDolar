from flask import Flask, current_app
from flask import json
from bs4 import BeautifulSoup
import urllib
from flask_cors import CORS, cross_origin


class Currency():
	def __init__(self, compra, venta):
		self.compra = compra
		self.venta = venta
	
	def toJSON(self):
		return json.dumps(self, default=lambda o: o.__dict__, 
			sort_keys=True, indent=4)

class Cotizacion():
	def __init__(self, usd=None, eur=None, real=None):
		self.usd = usd
		self.eur = eur
		self.real = real
	def to_usd(self):
		return self.usd
	def to_real(self):
		return self.real
	def to_eur(self):
		return self.eur

	def toJSON(self):
		return json.dumps(self, default=lambda o: o.__dict__, 
			sort_keys=True, indent=4)


class BancoNacionParser():
	
	def __init__(self, url):
		self.url = url;
	
	def openUrl(self):
		response = urllib.request.urlopen(self.url)
		html = response.read()
		return html

	def retrieve(self):
		soup = BeautifulSoup(self.openUrl(), 'html.parser')
		cotizacionDolar = []
		rows = soup.find(id="billetes").table.tbody.find_all('tr')

		for row in rows:
			column = row.find_all('td')
			cotizacionDolar.append([ele.text.strip() for ele in column])
		return Cotizacion(Currency(cotizacionDolar[0][1], cotizacionDolar[0][2]), 
Currency(cotizacionDolar[1][1], cotizacionDolar[1][2]), 
Currency(cotizacionDolar[2][1], cotizacionDolar[2][2]))





class CotizacionParser():
	
	def __init__(self):
		self.strategy = BancoNacionParser("http://www.bna.com.ar/")


	def retrieve(self):
		return self.strategy.retrieve()
	


app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route("/")
@cross_origin()
def index():
	return current_app.send_static_file('cotizacion.html')


@app.route("/usd")
@cross_origin()
def cotizacion_usd():
	cotizacion = CotizacionParser()
	response = app.response_class(
		response=cotizacion.retrieve().to_usd().toJSON(),
		status=200,
		mimetype='application/json'
	)
	return response

@app.route("/eur")
@cross_origin()
def cotizacion_eur():
	cotizacion = CotizacionParser()
	response = app.response_class(
		response=cotizacion.retrieve().to_eur().toJSON(),
		status=200,
		mimetype='application/json'
	)
	return response

@app.route("/real")
@cross_origin()
def cotizacion_real():
	cotizacion = CotizacionParser()
	response = app.response_class(
		response=cotizacion.retrieve().to_real().toJSON(),
		status=200,
		mimetype='application/json'
	)
	return response


app.run(host='0.0.0.0')
url_for('static', filename='cotizacion.html')

