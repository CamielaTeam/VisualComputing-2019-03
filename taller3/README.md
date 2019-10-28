# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

- [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
- [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Implemente la función `triangleRaster()` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/visualcomputing/nub/releases) (versión >= 0.2).

## Integrantes

Complete la tabla:

| Integrante                         | github nick |
| ---------------------------------- | ----------- |
| Lizeth Daniela Castellanos Alfonso | DaniCastel  |
| Camilo Alejandro Sanchez Cruz      | casc3798    |

## Discusión

Describa los resultados obtenidos. En el caso de anti-aliasing describir las técnicas exploradas, citando las referencias.

Se realizó la rasterización de un triángulo cuyos vértices son generados de manera aleatoria y su posterior sombreado a partir del color de sus vértices. Para esto se utilizaron coordenadas baricéntricas y la librería nub.

Se implementó una técnica de anti-aliasing en la cual se hace el uso de "subpixeles" para el suavizado de los bordes, al igual que para su sombreado.

Referencia de la implementación: https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation

## Entrega

- Plazo: ~~20/10/19~~ 27/10/19 a las 24h.
