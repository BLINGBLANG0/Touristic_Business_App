import 'package:flutter/material.dart';
import 'history_page.dart';
class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  Widget _buildVipMonthlySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "VIP ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(height: 4),
        Text(
          "• Access to premium services",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
  bool isAgreementChecked = false;
  String? selectedPlan; // To track the selected plan

            // Removed redundant invocation of _buildVipMonthlySection
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 196, 196),
      appBar: AppBar(
        title: const Text("Membership"),
        backgroundColor: const Color.fromARGB(255, 222, 119, 82),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
            icon: const Icon(Icons.history, size: 30, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // VIP Monthly Section
            _buildVipMonthlySection(),
            const SizedBox(height: 16),
            // Only for VIPs Section
            const Text(
              "Only for VIPs",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildVipFeatures(), // Build VIP features section
            const SizedBox(height: 16),
            // VIP Plans
            _buildVipPlans(),
            const SizedBox(height: 8),
            // Checkbox Agreement
            _buildAgreementCheckbox(),
          ],
        ),
      ),
      // BottomAppBar for the subscription button
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 225, 164, 110),
              minimumSize: const Size(double.infinity, 70),
            ),
            onPressed: isAgreementChecked && selectedPlan != null
                ? () {
                    // Perform subscription logic
                    print("Subscribed to plan: $selectedPlan");
                  }
                : null,
            child: const Text(
              "Subscribe now",
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVipFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "• Exclusive access to premium content",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text(
          "• Priority customer support",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text(
          "• Special discounts and offers",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildVipPlans() {
    return Column(
      children: [
        _buildPlanTile("1785 ", "5-star hotel suite", "private villa",
            "\$700 ", "Accommodation", const Color.fromARGB(255, 230, 180, 18)),
        _buildPlanTile("4900 ", "chauffeur", "private car",
            "\$1750 ", "Transport", Colors.red),
        _buildPlanTile("18025 ", "private chef", "Michelin star hotel",
            "\$6300 ", "Food", Colors.blue),
      ],
    );
  }

  Widget _buildPlanTile(String total, String coins, String freeCoins,
      String price, String planType, Color tagColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlan = planType; // Set the selected plan
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedPlan == planType
              ? Colors.green.withOpacity(0.8) // Highlight selected plan
              : Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  total,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  coins,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  freeCoins,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    planType,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isAgreementChecked,
          onChanged: (value) {
            setState(() {
              isAgreementChecked = value!;
            });
          },
        ),
        const Expanded(
          child: Text(
            "Confirmed and agreed to the Tourist Trail Subscription Service Agreement",
            style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(134, 51, 49, 49),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
