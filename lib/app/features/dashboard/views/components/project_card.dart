import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:project_management/app/constans/app_constants.dart';

class ProjectCardData {
  final double percent;
  final ImageProvider projectImage;
  final String projectName;
  final DateTime releaseTime;

  const ProjectCardData({
    required this.projectImage,
    required this.projectName,
    required this.releaseTime,
    required this.percent,
  });
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.data,
    Key? key,
    required this.service,
  }) : super(key: key);

  final data;
  final bool service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        service
            ? Container()
            :  Get.defaultDialog(
            title: 'Contract',
            content: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Client : ',
                      style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      data['user'],
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'address : ',
                      style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      data['address'],
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'services : ',
                      style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      data['services'],
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'type : ',
                      style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      data['type'],
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Information : ',
                      style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      data['info'],
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),

              ],
            )
        );
      },
      child: service
          ? data['isAccept'] == 1
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ProgressIndicator(
                      percent: 0.5,
                      center: _ProfilImage(
                          image: service
                              ? NetworkImage(data['image'] ??
                                  'https://freepngimg.com/thumb/mario/20698-7-mario-transparent-background.png')
                              : NetworkImage(data['image'] ??
                                  'https://freepngimg.com/thumb/mario/20698-7-mario-transparent-background.png')),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TitleText(service ? data['name'] : data['services']),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _SubtitleText(
                                  service ? "Release time : " : 'Order By'),
                              _ReleaseTimeText(
                                  service ? data['date'] : data['user'])
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Container()
          : data['isAccept'] == 1
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ProgressIndicator(
                      percent: 0.5,
                      center: _ProfilImage(
                          image: service
                              ? NetworkImage(data['image'] ??
                                  'https://freepngimg.com/thumb/mario/20698-7-mario-transparent-background.png')
                              : NetworkImage(data['image'] ??
                                  'https://freepngimg.com/thumb/mario/20698-7-mario-transparent-background.png')),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TitleText(service ? data['name'] : data['services']),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              _SubtitleText(
                                  service ? "Release time : " : 'Order By'),
                              _ReleaseTimeText(
                                  service ? data['date'] : data['user'])
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Container(),
    );
  }
}

/* -----------------------------> COMPONENTS <------------------------------ */
class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.percent,
    required this.center,
    Key? key,
  }) : super(key: key);

  final double percent;
  final Widget center;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 55,
      lineWidth: 2.0,
      percent: percent,
      center: center,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.blueGrey,
      progressColor: Theme.of(Get.context!).primaryColor,
    );
  }
}

class _ProfilImage extends StatelessWidget {
  const _ProfilImage({required this.image, Key? key}) : super(key: key);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image,
      radius: 20,
      backgroundColor: Colors.white,
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.capitalize!,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: kFontColorPallets[0],
        letterSpacing: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _SubtitleText extends StatelessWidget {
  const _SubtitleText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 11, color: kFontColorPallets[2]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ReleaseTimeText extends StatelessWidget {
  const _ReleaseTimeText(this.date, {Key? key}) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kNotifColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: Text(
        date,
        style: const TextStyle(fontSize: 9, color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
