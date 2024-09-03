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

//la idea es demostrar cómo todos los objetos están relacionados

//objetos cadete y gerente
//pepe le termina mandando mensaje a la categoría cuando se usa metodo sueldo()
//como la categoría está relacionada al neto y es la categoría la que tiene la mayor información sobre cuál es el neto, entonces
//se le pregunta a la propia categoría cuánto es el neto.

//en la 2da, hacer que el bono interactue con el neto.

//en vez de return categoria.neto() + tipoBonoResultados.bonoResultados() + tipoBonoPresentismo.bonoPresentismo();
//return self.neto() + self.bonoResultados() + self.bonoPresentismo()
//ya que ahí el dato te lo da el propio pepe mediante un método. Por tanto, se puede preguntarle con un mensaje a pepe cuál es su
//neto, su bonoResultados y su bonoPresentismo además del sueldo.
//esto está mejor así ya que son comportamientos de pepe!

//no tiene sentido hacer métodos como pepe.cadete() que te asigne al atributo categoria el objeto cadete, ya que si tenes 70
//categorías diferentes, vas a tener que crear 70 métodos distintos.

//tmb estaría re mal preguntarle al objeto quién es (si es igual a tal o cual), y, en base a eso, ejecutar un cierto código.
//en plan, if(categoria==cadete) { categoria.metodo; }
//la idea es usar polimorfismo y solo hacer categoria.neto(), y que, gracias al polimorfismo, la categoria correspondiente te
//devuelva el valor correspondiente mediante la ejecución del metodo neto().

//fijarse de volver parametrizables los métodos de los tipos de bono por resultados y los de los tipos de bono por presentismo,
//de modo que no solo funcionen en base a pepe, sino en base a cualquier otro empleado.
//O SEA, evitar el uso de referencias globales fijas y usar parámetros.
//para esto, TODOS los tipos de bono por resultados y los tipos de bono por presentismo deben recibir un parámetro para no romper
//el polimorfismo, AUN SI NO LO UTILIZAN. Esto en estructurado estaría mal, pero en objetos no.
//tmb podría pasar como parámetro la categoría o el neto.
//la mejor es el empleado porque defino que un bono es algo que se aplica a un empleado (algo que se relaciona directamente al empleado).

//estaría FATAL hacer a neto un atributo y neto = categoria.neto(), ya que eso es precálculo, debido a que, si cambia el valor del
//atributo neto de la categoría mediante un setter x ej, el atributo neto de pepe va a quedar desactualizado, por lo que, para que no
//pasara eso, habría que hacer al atributo neto de pepe dependiente del atributo de la categoria, de modo que cada vez que se actualiza
//ese se debe actualizar el otro.

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
