/*import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int approvedBookings = 0;
  int rejectedBookings = 0;
  int pendingBookings = 0;

  late DatabaseReference _bookingRef;

  @override
  void initState() {
    super.initState();

    _bookingRef = FirebaseDatabase.instance.ref().child('bookings');

    _bookingRef.onValue.listen((DatabaseEvent event) {
      final Map<dynamic, dynamic> data = event.snapshot.value as Map;

      int approvedCount = 0;
      int rejectedCount = 0;
      int pendingCount = 0;

      if (data != null) {
        data.forEach((key, value) {
          if (value['STATUS'] == 'Accepted') {
            approvedCount++;
          } else if (value['STATUS'] == 'Rejected') {
            rejectedCount++;
          } else if (value['STATUS'] == 'Initiated') {
            pendingCount++;
          }
        });
      }

      setState(() {
        approvedBookings = approvedCount;
        rejectedBookings = rejectedCount;
        pendingBookings = pendingCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BookingData, String>> _bookingData() {
      final data = [
        BookingData('Approved', approvedBookings),
        BookingData('Rejected', rejectedBookings),
        BookingData('Pending', pendingBookings),
      ];

      return [
        charts.Series<BookingData, String>(
          id: 'BookingData',
          domainFn: (BookingData booking, _) => booking.status,
          measureFn: (BookingData booking, _) => booking.count,
          data: data,
          labelAccessorFn: (BookingData booking, _) => '${booking.status}: ${booking.count}',
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Bookings'),
            SizedBox(height: 20),
            Text('${approvedBookings + rejectedBookings + pendingBookings}'),
            SizedBox(height: 20),
            Expanded(
              child: charts.PieChart(
                _bookingData(),
                animate: true,
                animationDuration: Duration(milliseconds: 500),
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 10,
                  arcRendererDecorators:ch
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingData {
  final String status;
  final int count;

  BookingData(this.status, this.count);
}
*/