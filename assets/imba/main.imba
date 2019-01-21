# Inject btc ticker
import PriceTicker from './views/price_ticker'
let tickerElems = document.getElementsByName('price-ticker')
for tickerElem in tickerElems
  Imba.mount(<PriceTicker label=tickerElem.getAttribute('data-label') ticker=tickerElem.getAttribute('data-ticker')>, tickerElem)

# Inject the content page
let contentElem = document.getElementById('main-content')
let contentType = contentElem.getAttribute('data-content')

if contentType === "welcome"
  import {Welcome} from './views/welcome'
  Imba.mount(<Welcome>, contentElem)
else if contentType === "psc"
  import {Psc} from './views/psc'
  Imba.mount(<Psc>, contentElem)