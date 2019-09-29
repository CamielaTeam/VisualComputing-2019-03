# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

- Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
- Aplicación de algunas [máscaras de convolución](<https://en.wikipedia.org/wiki/Kernel_(image_processing)>).
- (solo para imágenes) Despliegue del histograma.
- (solo para imágenes) Segmentación de la imagen a partir del histograma.
- (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

### Alternativas para video en Linux y `gstreamer >=1`

Distribuciones recientes de Linux que emplean `gstreamer >=1`, requieren alguna de las siguientes librerías de video:

1. [Beta oficial](https://github.com/processing/processing-video/releases).
2. [Gohai port](https://github.com/gohai/processing-video/releases/tag/v1.0.2).

Descompriman el archivo `*.zip` en la caperta de `libraries` de su sketchbook (e.g., `$HOME/sketchbook/libraries`) y probar cuál de las dos va mejor.

## Integrantes

Completar la tabla:

| Integrante                         | github nick |
| ---------------------------------- | ----------- |
| Camilo Alejandro Sánchez Cruz      | casc3798    |
| Lizeth Daniela Castellanos Alfonso | DaniCastel  |

## Discusión

Para imágenes:
Se realizó la conversión a escala de grises con los métodos de rgb average y luma. Se encontró que el método luma mantiene más
el efecto de brillo en la imágen en comparación al método de rgb average. Se realizó un histograma de color en ambos casos, el
cual permite la selección de un rango para segmentar la imágen a partir del intervalo de colores seleccionado.

Se aplicaron máscaras convolucionales de 3x3 a imágenes, tomando como muestra principalmente aquellas que resaltan bordes,
se ignoraron las conversiones en los bordes de la imágen para facilidad de la implementación.

Para videos:
Se aplicó la conversión a escala de grises (se utilizó la librería Video para Windows, la cual es mantenida por
processing), en ambos casos (rgb average y luma) se inicia con poco frame rate (sin embargo esto sucede incluso al cargar
un video sin realizar la conversión, por lo que es posible que siempre suceda al inicio de carga del video), aproximadamente
9 y luego se estabiliza a 59/60 (se escogió 60 como el límite de frames). Los mismos resultados fueron obtenidos para la
máscara de convolución.

## Entrega

- Plazo para hacer _push_ del repositorio a github: 29/9/19 a las 24h.
