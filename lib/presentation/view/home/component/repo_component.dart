

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_apps_deall/data/models/body/repository_body.dart';
import 'package:github_apps_deall/utils/helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class RepoComponent extends StatelessWidget {
  final RepositoryBody data;

  const RepoComponent({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Helpers.redirectUrl(data.html_url);
      },
      child: Container(
        width: Helpers.getWidthPageSize(context),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xff3C3F48),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius: 1.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: "${data.owner?.avatar_url}",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.name}",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        Helpers.dateFormatFromTimestampZFAndFormat("${data.created_at}", "dd MMMM yyyy"),
                        style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: Helpers.getWidthPageSize(context),
              height: 1,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4)
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${data.watchers_count}",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        "Watcher",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${data.stargazers_count}",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        "Stars",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${data.forks_count}",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        "Fork",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
