//empleados/personas

object pepe {

    var categoria = cadete;
    var tipoBonoResultados = porcentaje;
    var tipoBonoPresentismo = normal;
    var faltasMensuales = 0;

    method categoria(_categoria) {
        categoria = _categoria;
    }

    method tipoBonoResultados(_tipoBonoResultados) {
        tipoBonoResultados = _tipoBonoResultados;
    }

    method tipoBonoPresentismo(_tipoBonoPresentismo) {
        tipoBonoPresentismo = _tipoBonoPresentismo;
    }

    method faltasMensuales() {
        return faltasMensuales;
    }

    method faltasMensuales(_faltasMensuales) {
        faltasMensuales = _faltasMensuales;
    }

    method neto() {
        return categoria.neto();
    }

    method bonoResultados() {
        return tipoBonoResultados.bonoResultados(self);
    }

    method bonoPresentismo() {
        return tipoBonoPresentismo.bonoPresentismo(self);
    }
    //acá podría pasar las faltas sino, ya que se calcula directamente sobre las faltas.

	method sueldo() {
        return self.neto() + self.bonoResultados() + self.bonoPresentismo();
    }
}

object sofia {
    var categoria = cadete;
    var tipoBonoResultados = porcentaje;
    const porcentajeSobreNeto = 1.3; //como es algo que se usa en un cálculo, se lo hace constante para dar claridad al método

    method categoria(_categoria) {
        categoria = _categoria;
    }

    method tipoBonoResultados(_tipoBonoResultados) {
        tipoBonoResultados = _tipoBonoResultados;
    }

    method neto() {
        return categoria.neto() * porcentajeSobreNeto;
    }

    method bonoResultados() {
        return tipoBonoResultados.bonoResultados(self);
    }

    method sueldo() {
        return self.neto() + self.bonoResultados();
    }

}

object roque {

    //var categoria = cadete; no va porque esto sirve para calcular el neto, y, en este caso, el neto es fijo
    var tipoBonoResultados = porcentaje;
    const bonoFijo = 9000; //como es algo que se usa en un cálculo, se lo hace constante para dar claridad al método

    method tipoBonoResultados(_tipoBonoResultados) {
        tipoBonoResultados = _tipoBonoResultados;
    }

    method neto() {
        return 28000;
    }

    method bonoResultados() {
        return tipoBonoResultados.bonoResultados(self);
    }

	method sueldo() {
        return self.neto() + self.bonoResultados() + bonoFijo;
    }
}

object ernesto {

    //var categoria = cadete; No va porque esta nos sirve para calcular el neto, y el neto se obtiene en base a quien tiene por compañero
    //const faltasMensuales = 0; Ni hace falta porque es una constante que NI SIQUIERA se usa en un cálculo. Solo se retornaría
    //                           en faltasMensuales(), por lo que me parece mejor simplemente retornar 0 ahí y listo.
    //                           Tiene sentido declararla cuando es variable y se usa con setter o cuando es constante y se usa en un cálculo,
    //                           de modo que de mayor claridad al método. Acá NO.
    var tipoBonoPresentismo = normal;
    var companhero = pepe;

    method tipoBonoPresentismo(_tipoBonoPresentismo) {
        tipoBonoPresentismo = _tipoBonoPresentismo;
    }

    method faltasMensuales() {
        return 0; //y no hace falta un setter porque siempre es 0 (constante)
    }

    method companhero(persona) {
        companhero = persona;
    }

    method neto() {
        return companhero.neto(); //aunque sea el neto del compañero, tiene que poder seguir entendiendo el mensaje neto para el polimorfismo
    }

    method bonoPresentismo() {
        return tipoBonoPresentismo.bonoPresentismo(self);
    }
    //acá podría pasar las faltas sino, ya que se calcula directamente sobre las faltas.

	method sueldo() {
        return self.neto() + self.bonoPresentismo();
    }
}

//categorias (neto)

object gerente {
    method neto() {
        return 15000
    }
}

object cadete {
    method neto() {
        return 20000
    }
}

object vendedor {
    var porcentajeAumento = 1;

    method activarAumentoPorMuchasVentas() {
        porcentajeAumento = 1.25;
    }

    method desactivarAumentoPorMuchasVentas() {
        porcentajeAumento = 1;
    }

    method neto() {
        return 16000 * porcentajeAumento;
    }
}

//medioTiempo es realmente un modificador sobre categorías

object medioTiempo {
    
    var categoriaBase = cadete;
    const descuentoPorMedioTiempo = 2;
    
    method categoriaBase(categoria) {
        categoriaBase = categoria;
    }

    method neto() {
        return categoriaBase.neto() / descuentoPorMedioTiempo;
    }

}

//tipos de bono por resultados

object porcentaje {
    method bonoResultados(empleado) {
        return 10 * empleado.neto() / 100;
    }  
}

object montoFijo {
    method bonoResultados(empleado) {
        return 800;
    }
}

//tipo de bono por resultados y por presentismo
object nulo {
    method bonoResultados(empleado) {
        return 0;
    }

    method bonoPresentismo(empleado) {
        return 0
    }
}

//tipos de bono por presentismo

object normal {
    method bonoPresentismo(empleado) {
        if(empleado.faltasMensuales()==0) {
            return 2000;
        } else if(empleado.faltasMensuales()==1) {
            return 1000;
        } else {
            return 0;
        }
    }
}

//si bien no hay ningún problema conceptual con los ifs, es posible remplazarlos por una fórmula/calculo como cuando calculabamos
//la deuda de las empanadas en la práctica pasada (saldo.min(0).abs())
//esa fórmula podría ser así:
// return (2000 - (empleado.faltasMensuales() * 1000) ).max(0)

object ajuste {
    method bonoPresentismo(empleado) {
        if(empleado.faltasMensuales()==0) {
            return 100;
        } else {
            return 0;
        } 
    }
}

//tmb podría usarse el if como operador ternario: (expresión booleana) ? a : b;
//quedaría
//return if (empleado.faltasMensuales()==0) 100 else 0;

object demagogico {
    method bonoPresentismo(empleado) {
        if(empleado.neto() < 18000) {
            return 500;
        } else {
            return 300;
        }
    }
}
