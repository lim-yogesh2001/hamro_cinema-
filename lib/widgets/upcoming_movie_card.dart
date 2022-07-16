import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_cinema/models/movie.dart';
import 'package:intl/intl.dart';

class UpcomingMovieCard extends StatelessWidget {
  const UpcomingMovieCard({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            imageUrl: movie.coverImage,
            imageBuilder: (context, image) => ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.srcOver),
                child: Image(
                  isAntiAlias: true,
                  image: image, fit: BoxFit.cover,
                  // width: SizeConfig.imageSizeMultiplier * 25,
                  height: MediaQuery.of(context).size.height * 35,
                  width: MediaQuery.of(context).size.width * 90,
                ),
              ),
            ),
            errorWidget: (context, _, __) {
              return const Icon(Icons.error_outlined);
            },
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("yyyy MMMM dd").format(movie.releaseDate),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                movie.movieName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
