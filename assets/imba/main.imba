let contentElem = document.getElementById('main-content')
let contentType = contentElem.getAttribute('data-content')

if contentType === "welcome"
  import {Welcome} from './views/welcome'
  Imba.mount(<Welcome>, contentElem)
else if contentType === "psc"
  import {Psc} from './views/psc'
  Imba.mount(<Psc>, contentElem)