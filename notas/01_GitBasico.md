# `git` ultrabásico

<img src="https://raw.githubusercontent.com/louim/in-case-of-fire/master/in_case_of_fire.png" title="In case of fire (https://github.com/louim/in-case-of-fire)" width="280" height="200" align="center">

---

# ¿Qué es `git`?

`git` es un sistema de control de versiones descentralizado. `git` permite desarrollar proyectos colaborativos de manera coordinada, distribuida (descentralizada, cada quien tiene una copia íntegra), incremental y eficiente, preservando *la historia* del proyecto en cada copia del proyecto.

`git` funciona desde la línea de comandos, aunque también existen versiones gráficas, e incluso editores que lo incorporan.

> La idea de estas notas sobre `git` es que tengan el material *a la mano*, en caso de que no recuerden algo básico.

---

# Configuración básica

Una vez instalado `git`, lo primero que hay que hacer es configurarlo para que `git` atribuya el trabajo de manera correcta a quien lo hace. Para esto, desde la terminal, ejecutaremos una serie de comandos:

```git
git config --global user.name "Su Nombre de Verdad"

git config --global user.email "usuario@email_de_verdad"

git config --global github.user "Usuario_GitHub"

git config --global color.ui "auto"
```

Los compandos anteriores guardan estas opciones de manera *global*, es decir, escribiendo en el archivo `~/.gitconfig`. Si por alguna razón prefieren tener una configuración *local* en relación a un proyecto concreto, las mismas instrucciones las pueden usar reemplazando `--global` por `--local`. Esto lo deben hacer desde el directorio donde reside el proyecto, y el efecto es que escribirá estas opciones en el archivo `.git/config` relativo al repositorio.

---

# Flujo de trabajo

De manera totalmente abstracta por ahora, el flujo de trabajo en `git` consiste en:

(0) Trabajar desde una rama *separada* a la principal (que se llama `main`, o para proyectos un poco más antiguos, `master`). Por esto, uno debe primero *cambiarse* a la rama donde quiere trabajar, o *crear* dicha rama. De esta manera, no se alterará el estado de la rama principal del proyecto.

Para crear una rama, se utiliza el comando:

```git
git checkout -b <nombre_de_la_rama>
```

mientras que para cambiarse a la rama (que ya existe) se utiliza
```git
git checkout <nombre_de_la_rama>
```

> Es **muy importante** que **siempre** trabajen desde ramas que no sean la principal.

---

(1) Los "cambios" en el proyecto se hacen *cambiando* uno o varios archivos existentes, creado o borrando algunos archivos. Para registrar los cambios hechos en el archivo `<file>`, uno debe primero *añadirlos* al "índice" de git, que es una zona de almacenamiento temporal. Para esto usamos el comando:
```git
git add <file>
```

Nuevos cambios pueden ser realizados e incorporados en `<file>` a presar de que ya han sido agregados al índice, incluso si involucran a otros archivos; para que dichos nuevos cambios se registren *deben* añadirse nuevamente a la zona temporal. El "índice" es una zona de almacenamiento intermedia para, en algún sentido, ir mejorando los cambios que uno quiere hacer, permitiendo hacer pruebas o repensar si uno los quiere incluir.

---

(2) Eventualmente, los cambios hechos se quieren en guardar de una manera más definitiva y explícita. Esto se hace a través del comando:
```git
git commit -m "Resumen de los cambios realizados en una línea máximo"
```
El mensaje, que puede detallarse aún más, justamente sirve para describir los cambios hechos.
(Internamente, `git` actualiza el puntero `HEAD`, que es lo que marca la versión actual del desarrollo de la rama.) Los cambios así incorporados se conocen como *commits* (comprometidos).

`git` tiene una amplísima flexibilidad: Uno puede *cambiar* el orden de los *commit*s en el historial, cambiar la estructura uniéndolos en uno, por ejemplo.

> Lo importante es ir "guardando" los pasos del trabajo hecho, y avanzar hasta que "se complete" el objetivo del cambio que se propone.

---

(3) Finalmente, para evitar la pérdida del trabajo uno debe respaldar el trabajo. Una alternativa gratuita es usar [GitHub](https://github.com), y existen otras como [Gitlab](https://gitlab.com) que ofrece poder configurar servidores propios en lugar de los que ofrece Gitlab. Esto se hace *empujando* los cambios hacia el servidor "remoto", usando el comando
```git
git push <remote> <branch>
```
donde `<remote>` es el alias (abreviación) del servidor remoto, y `<branch>` es la rama a donde se quieren empujar los cambios. Sin entrer en detalles ahora, estos aspectos se pueden configurar y no deben ser únicos. Esa flexibilidad es la que hace a `git` ser una herramienta colaborativa.

Todos estos pasos explican el meme incluído al principio: en caso de emergencia, 1) `git add` + `git commit`, 2) `git push`, y entonces 3) se puede abandonar el edificio.

---

# Comandos básicos

```git
git help
```

Ayuda básica sobre `git`; en particular, despliega varios comandos útiles. Para obtener el manual correspondiente a cada comando se usa
```git
    git help <command>
```

---

```git
git init
```

Sirve para inicializar cualquier repositorio local `git`. Este comando crea un nuevo directorio local (`.git/`) donde se almacena toda la información necesaria del repositorio. Típicamente, se utiliza una vez este comando.

---

```git
git checkout
```

Este comando tiene varios usos relacionados con las ramas de desarrollo de un proyecto. La idea de las ramas (o *branch*-es) es poder hacer cambios específico sin alterar la versión principal del repositorio (que están en la rama `main` que antes se solía llamar `master`), de una manera independiente respecto a otros desarrolladores. Esto permite el trabajo en paralelo, incluyendo hacer pruebas "disruptivas" sin que afectan el funcionamiento operativo de la librería.

```git
    git checkout -b <nombre_rama>
```

Sirve para *crear* y cambiarnos una nueva rama


```git
    git checkout <nombre_rama>
```

Permite cambiarse de rama. La rama *principal* por convención es la rama `main` o la rama `master`.

```git
    git checkout -- <file>
```

Sirve para revertir ciertos cambios en uno o varios archivos.

---

```git
git status
```

Muestra el estado del repositorio: por un lado, muestra la rama en la que se está trabajando, los cambios en los archivos que  están incluidos en  el proyecto, o de los que aún no se siguen, los archivos que están en el "índice" pero que aún no se "comprometen", etc.

---

```git
git log
```

Muestra la información sobre los commits que se han hecho en el repositorio, mostrando primero los commits más recientes. Existen varias formas útiles simplificadas:
```git
    git log --oneline
    git log --graph
```

---

```git
git add <files>
```

Agrega el contenido del archivo a la lista de archivos (índice) cuyos cambios se seguirán en el repositorio.

```git
git commit -m "Message about commit"
```

Este comando "compromete" los cambios hechos y agregados con `git add`, es decir, los incluye en el historial preciso del repositorio través de actualizar el puntero `HEAD`. La información que aquí se escribe es a la que se tiene acceso con `git log`.

---

```git
git merge <rama1> <rama2>
```

Este comando permite unir dos o más ramas en una sola, es decir, incorpora el historial de las ramas en la rama "actual" (desde la que se utiliza el comando). La aplicación más importante es incluir los desarrollos en la rama `main`, aunque en general esto se hace en GitHub y es la culminación de un *pull request*. Sin embargo, a veces durante una colaboración, uno puede unir una rama, por ejemplo la rama `tarea1_ej2`, a otra rama `tarea1`, donde la segunda concentra los cambios y aportaciones importantes y que es *desde donde* se hace el *pull request*. Este comando intenta preservar las historias de ambas ramas, y sólo cuando esto se satisface es que se unen las ramas.

---

Los siguientes comandos son de interés a la hora de trabajar con versiones remotas del repositorio, y son importantes para los aspectos colaborativos de `git`.

```git
git push [<remote> <rama>]
```

Este comando actualizará la versión remota de un repositorio local (se pueden tener varias versiones remotas!) "subiendo" los cambios hechos localmente.

---

```git
git pull [<remote> <rama>]
```

Este comando actualizará la versión local de un repositorio, a partir de los cambios que hay en la dirección "remota" del repositorio.

---

```git
git clone <direccion_repo>
```

Permite crear una copia *local* de un repositorio remoto, que se especifica a través de su dirección. La copia local contiene el historial íntegro del repositorio remoto.

---

```git
git stash
git stash pop
git stash list
```

En ocasiones, al trabajar (en la rama `rama1`) debemos hacer modificaciones de otro archivo (que haremos en otra rama independiente, `rama2`) y no queremos que los cambios que estamos implementando ni se reflejen en la historia ni en la otra rama. El comando `git stash` sirve para guardar los cambios ya hechos sin necesidad de hacer un commit. En este caso, los cambios se guardan (para acceder a ellos posteriormente), se regresa al "último estado de la historia", y entonces uno puede implementar los otros cambios que se requieren. Si quieremos recuperar los cambios guardados hacemos `git stash pop`. Se pueden además tener *varios* cambios "arrumbados"; para ver cuales se tienen usamos `git stash list`.

---

# `git` colaborativo

A fin de contribuir a un proyecto remoto del cual **no** somos los "propietarios", o simplemente no tenemos permiso de escribir, lo que es común, es típico hacer una copia (propia) del repositorio al que se quiere contribuir a partir de su propia cuenta en [GitHub](https://github.com). Esto se hace haciendo un *fork*, es decir, creando una bifurcación del proyecto original.

Es en el fork (local) donde ustedes pueden hacer cambios o pruebas de manera libre. Eventualmente, subirán los cambios a su copia del fork en  GitHub (donde ustedes pueden escribir!). Eventualmente, ustedes pueden hacer una *petición* para que sus cambios sean incluidos en el proyecto principal. Esto se hace a través de un *pull request*.

Esta opción de hacer cambios y proponerlos para pertenecer al proyecto externo es la esencia del *software abierto*.

Una liga útil: [How to make your first pull request on GitHub](https://www.freecodecamp.org/news/how-to-make-your-first-pull-request-on-github-3/).

---

# Servidores remotos

Uno debe tener claro que uno parte de tener una copia íntegra del repositorio en su propia máquina. Esta copia es la que hace que el desarrollo no sea centralizado. El repositorio, además de estar en cada una las máquinas que han clonado localmente el  repositorio, típicamente se encuentra en un espacio "público" común, como [GitHub](https://github.com) o [Gitlab](https://gitlab.com); a pesar de que el repositorio se encuentre en estas plataformas, el acceso puede ser restringido, cosa que se configura directamente en la plataforma.

El comando
```git
git clone <url_del_fork>
```
permite clonar un repositorio remoto a un directorio local.

`git` permite seguir los cambios al mismo repositorio, manejando sitios remotos distintos ligados al mismo proyecto. Por ejemplo, uno de los sitios remotos es el proyecto oficial, otro la versión "fork" (propia) que hemos hecho del propio proyecto, y un tercero donde se comparte el desarrollo de una tarea con un compañerE del mismo equipo.

> Algo importante es que hay dos tipos de URL que se  pueden especificar al momento de clonar un repositorio, y esto se relaciona con la manera en que uno se identifica en [GitHub](https://github.com); usen el que más les convenga.

Para ver qué configuración se tiene de los repositorios remotos, uno ejecuta
```git
git remote -v
```
(La opción `-v` significa *verbose*, es decir, que se den detalles extra.)

Si uno quiere agregar un nuevo servidor remoto a su máquina local, por ejemplo, para tener la copia oficial y también la del fork clonado (donde sí podemos empujar cambios propios), se necesita agregar los datos del nuevo `remote`, usando el comando:
```git
git remote add <alias> <url_del_fork>
```
donde `<url_del_fork>` es la dirección donde está nuestro fork (en [GitHub](https://github.com)), y `<alias>` es la abreviación que le daremos, por ejemplo, "fork", "mifork" o "copia_clase".

La distinción entre el repositorio oficial y el fork, y por tanto sus abreviaciones (o alias), son importantes en el sentido de cuál será el utilizado como default, cuando uno omite escribir el `remote` en los comandos `git pull` o `git push`. Como convención podemos decir que `origin` será el proyecto original, y nuestro fork será `mifork`.
Entonces, el comando
```git
git push mifork
```
empujará los cambios a `mifork` usando la rama en la que estemos trabajando, y desde GitHub, podremos poner a consideración (*pull request*) estos cambios para que puedan ser incluidos en el repositorio oficial.

Para tener actualizada la rama principal `main` con la rama principal del proyecto original, y entonces actualizar la rama principal  de nuestro fork, lo que debenrán hacer es:
```git
git checkout main
git pull origin
git push mifork
```
La primer instrucción nos cambia a la rama `main`, la segunda jala (actualiza) del remote `origin` los cambios a la máquina local (si es que los hay), y la última actualiza nuestro fork en GitHub, también a la rama `main`. A pesar de que la primer instrucción aparezca como una que puede no crear problemas, puede que sea necesario guardar o revertir cambios que hemos hecho antes de podernos cambiar de ramas.

---

# Ramas

Un punto **esencial** para hacer de `git` sea una herramienta colaborativa eficiente, es el uso de ramas (*branch*-es). Trabajar distintas cosas en distintas ramas es lo mejor que pueden hacer.

La idea es trabajar en una rama independiente, cosa que equivale a una copia íntegra de la rama `main` que se crea a partir del lugar/momento (commit) en el que se crea la rama. Esta descripción es simplista, en el sentido de que crear una rama no involucra hacer copias, sino redirigir ciertas ligas simbólicas, lo que hace que crear ramas "sea barato" en cuanto a utilización de disco. Como hemos dicho antes, en la nueva rama uno hace los cambios específicos, que eventualmente se enviarán para ser considerados como nueva aportación al proyecto.

Para crear una rama, uno puede usar el comando
```git
git branch <nombre_rama>
```
donde "nombre_rama" será el nombre de la nueva rama creada. El comando anterior crea la rama, pero no nos cambia a esa rama. Para cambiarnos, como se describió antes, utilizamos el comando
```git
git checkout <nombre_rama>
```

Para ver qué ramas hay en el proyecto, uno usa el comando
```git
git branch -v
```

Una manera más simplificada de crear la rama y cambiarnos a ella es usar el comando
```git
    git checkout -b <nombre_rama>
```
El commit en la rama desde la que se crea una nueva, aparece íntegramente en la nueva rama. Los "commits" sucesivos se incorporan a esta rama y pueden ser unidos, de distintas maneras, a la rama principal.

---

# Algunas ligas útiles:

- [Learn git branching](https://learngitbranching.js.org/)

- [Git & GitHub Crash Course For Beginners](https://www.youtube.com/watch?v=SWYqp7iY_Tc)

- [Git - the simple guide](https://rogerdudler.github.io/git-guide/)

- [How to make your first pull request on GitHub](https://www.freecodecamp.org/news/how-to-make-your-first-pull-request-on-github-3/)
