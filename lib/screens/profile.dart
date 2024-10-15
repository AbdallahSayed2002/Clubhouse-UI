import 'package:cached_network_image/cached_network_image.dart';
import 'package:clubhouse_ui/data.dart';
import 'package:clubhouse_ui/screens/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String name;
  final int age;
  final List<String> imageUrls; // Multiple image URLs

  const Profile({
    super.key,
    required this.name,
    required this.age,
    required this.imageUrls,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PageController _pageController = PageController(viewportFraction: 0.8); // Set viewport for custom animation

  @override
  void dispose() {
    _pageController.dispose(); // Dispose controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.left_chevron),
        ),
        actions: [
          IconButton(onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MapScreen(imageUrl: currentUser.imageURL,))), icon: Icon(CupertinoIcons.location_solid))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.grey.withOpacity(0.0001),
                      child: SizedBox(
                        height: screenHeight * 0.5, // Set dialog height
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.imageUrls.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                double value = 1.0;

                                if (_pageController.position.haveDimensions) {
                                  value = _pageController.page! - index;
                                  value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                                }

                                return Center(
                                  child: SizedBox(
                                    height: Curves.easeOut.transform(value) * screenHeight * 0.5,
                                    width: Curves.easeOut.transform(value) * screenWidth * 0.8,
                                    child: child,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add space between images
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrls[index],
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: ClipOval(
                child: CachedNetworkImage(
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.52,
                  imageUrl: widget.imageUrls[0], // Display the first image by default
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.black54),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              "Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.07,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Age years old",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.07,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Phone Number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.07,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
