import 'package:flutter/material.dart';
import '../../../../core/widgets/logo/carliet_logo.dart';
import '../../../features/student/presentation/internship_details_page.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: const _BottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _HeaderSection(),
              const _BodyContent(),
            ],
          ),
        ),
      ),
    );
  }
}

// Header section

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 45),
      decoration: const BoxDecoration(
        color: Color(0xFF087E8B), 
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    child: const Logo(height: 60),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'CarLi_ET Internship',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              
              Theme(
                data: Theme.of(context).copyWith(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: PopupMenuButton<int>(
                  offset: const Offset(0, 55),
                  constraints: const BoxConstraints(minWidth: 320, maxWidth: 320),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      enabled: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 15, top: 10),
                            child: Text(
                              "Notifications",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          _buildNotificationItem("Ethiotelecom"),
                          const Divider(height: 25),
                          _buildNotificationItem("Ethiotelecom"),
                          const Divider(height: 25),
                          _buildNotificationItem("Ethiotelecom"),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 35),

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Internship\nOpportunity',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF08363B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Browse Internships',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5A93D),
                      width: 5,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/images/profile_placeholder.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String companyName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(Icons.circle, color: Color(0xFF087E8B), size: 8),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                companyName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 14, 
                  color: Colors.black87
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                "Your application on the 'Assistant Field Operation Technician'...",
                style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/images/ethiotelecom.jpg',
          width: 32,
          height: 32,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => 
              const Icon(Icons.business, size: 32, color: Colors.grey),
        ),
      ],
    );
  }
}
// Body section
class _BodyContent extends StatelessWidget {
  const _BodyContent();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -25),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
          child: Column(
            children: [
              _buildCardRow([
                const _InstitutionCard(
                  name: "Ethio telecom",
                  description: "Africa's pioneer telecom provider...",
                  assetPath: 'assets/images/ethiotelecom.jpg',
                ),
                const _InstitutionCard(
                  name: "CBE",
                  description: "Leading bank in Ethiopia...",
                  assetPath: 'assets/images/CBE.jpg',
                ),
                const _InstitutionCard(
                  name: "Ride",
                  description: "Business solutions to poverty...",
                  assetPath: 'assets/images/ride.jpg',
                ),
              ]),
              const SizedBox(height: 30),
              _buildCardRow([
                const _InstitutionCard(
                  name: "Ethiopian Airlines",
                  description: "Transforming lives with tech...",
                  assetPath: 'assets/images/airlines.jpg',
                ),
                const _InstitutionCard(
                  name: "Google",
                  description: "The choice for tomorrow...",
                  assetPath: 'assets/images/google.jpg',
                ),
                const _InstitutionCard(
                  name: "Dashen",
                  description: "Always one step ahead...",
                  assetPath: 'assets/images/dashen.jpg',
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardRow(List<Widget> cards) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cards.map((card) => Expanded(child: card)).toList(),
    );
  }
}

class _InstitutionCard extends StatelessWidget {
  final String name;
  final String description;
  final String assetPath;

  const _InstitutionCard({
    required this.name,
    required this.description,
    required this.assetPath,
  });

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InternshipDetailsPage(
          data: {
            'company': name,
            'image': assetPath,
            'title': 'Internship Program',
            'desc': description,
            'loc': 'Addis Ababa',
            'dur': '3 Months',
            'sal': 'Paid',
            'tags': '#Engineering #Tech',
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160, 
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.business, size: 40, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 9, 
              color: Colors.grey, 
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () => _navigateToDetails(context),
                child: const Text(
                  "Read more",
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF087E8B),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 24,
                child: ElevatedButton(
                  onPressed: () => _navigateToDetails(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    "Apply", 
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// Bottom navigation bar
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF087E8B), 
          borderRadius: BorderRadius.circular(35), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), 
              blurRadius: 15, 
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            IconButton(
              icon: const Icon(
                Icons.grid_view_rounded, 
                color: Colors.white, 
                size: 26,
              ), 
              onPressed: () {
               
              },
            ),

            
            Container(
              padding: const EdgeInsets.all(12), 
              decoration: const BoxDecoration(
                color: Colors.white, 
                shape: BoxShape.circle,
              ), 
              child: const Icon(
                Icons.home_rounded, 
                color: Color(0xFF087E8B), 
                size: 26,
              ),
            ),

            
            IconButton(
              icon: const Icon(
                Icons.groups_2_outlined, 
                color: Colors.white, 
                size: 30,
              ), 
              onPressed: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}

