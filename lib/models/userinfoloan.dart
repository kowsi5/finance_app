// class ApiResponse {
//   final int code;
//   final UserData data;

//   ApiResponse({
//     required this.code,
//     required this.data,
//   });

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return ApiResponse(
//       code: json['code'] ?? 0, // Default to 0 if missing
//       data: json.containsKey('data')
//           ? UserData.fromJson(json['data'])
//           : UserData.fromJson({}),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'code': code,
//       'data': data.toJson(),
//     };
//   }
// }

// class UserData {
//   final String name;
//   final String loanId;
//   final String mobile;
//   final String imgPath;
//   final String status;
//   final String branch;
//   final int numberOfLoans;
//   final int active;
//   final int closed;
//   final List<Loan> loans;

//   UserData({
//     required this.name,
//     required this.loanId,
//     required this.mobile,
//     required this.imgPath,
//     required this.status,
//     required this.branch,
//     required this.numberOfLoans,
//     required this.active,
//     required this.closed,
//     required this.loans,
//   });

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     var loansList = json['loans'] as List;
//     List<Loan> loans = loansList.map((i) => Loan.fromJson(i)).toList();

//     return UserData(
//       name: json['name'],
//       loanId: json['loan_id'],
//       mobile: json['mobile'],
//       imgPath: json['imgpath'],
//       status: json['status'],
//       branch: json['Branch'],
//       numberOfLoans: json['no_of_loans'],
//       active: json['active'],
//       closed: json['closed'],
//       loans: loans,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'loan_id': loanId,
//       'mobile': mobile,
//       'imgpath': imgPath,
//       'status': status,
//       'Branch': branch,
//       'no_of_loans': numberOfLoans,
//       'active': active,
//       'closed': closed,
//       'loans': loans.map((i) => i.toJson()).toList(),
//     };
//   }
// }

// class Loan {
//   final String loanNo;
//   final String status;
//   final double totalAmount;
//   final double paidAmount;
//   final double balanceAmount;
//   final double totalDue;
//   final double paidDue;
//   final double balanceDue;
//   final DateTime loanStart;
//   final DateTime loanEnd;
//   final List<LoanSummary> loanSummary;

//   Loan({
//     required this.loanNo,
//     required this.status,
//     required this.totalAmount,
//     required this.paidAmount,
//     required this.balanceAmount,
//     required this.totalDue,
//     required this.paidDue,
//     required this.balanceDue,
//     required this.loanStart,
//     required this.loanEnd,
//     required this.loanSummary,
//   });

//   factory Loan.fromJson(Map<String, dynamic> json) {
//     var loanSummaryList = json['loansummary'] as List;
//     List<LoanSummary> loanSummary =
//         loanSummaryList.map((i) => LoanSummary.fromJson(i)).toList();

//     return Loan(
//       loanNo: json['loan_no'],
//       status: json['status'],
//       totalAmount: json['total_amount'].toDouble(),
//       paidAmount: json['paid_amount'].toDouble(),
//       balanceAmount: json['balance_amount'].toDouble(),
//       totalDue: json['total_due'].toDouble(),
//       paidDue: json['paid_due'].toDouble(),
//       balanceDue: json['balance_due'].toDouble(),
//       loanStart: DateTime.parse(json['loanstart']),
//       loanEnd: DateTime.parse(json['loanend']),
//       loanSummary: loanSummary,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'loan_no': loanNo,
//       'status': status,
//       'total_amount': totalAmount,
//       'paid_amount': paidAmount,
//       'balance_amount': balanceAmount,
//       'total_due': totalDue,
//       'paid_due': paidDue,
//       'balance_due': balanceDue,
//       'loanstart': loanStart.toIso8601String(),
//       'loanend': loanEnd.toIso8601String(),
//       'loansummary': loanSummary.map((i) => i.toJson()).toList(),
//     };
//   }
// }

// class LoanSummary {
//   final String loanNo;
//   final String status;
//   final double paidAmount;
//   final DateTime date;

//   LoanSummary({
//     required this.loanNo,
//     required this.status,
//     required this.paidAmount,
//     required this.date,
//   });

//   factory LoanSummary.fromJson(Map<String, dynamic> json) {
//     return LoanSummary(
//       loanNo: json['loan_no'],
//       status: json['status'],
//       paidAmount: double.parse(json['paidamount']),
//       date: DateTime.parse(json['date']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'loan_no': loanNo,
//       'status': status,
//       'paidamount': paidAmount.toString(),
//       'date': date.toIso8601String(),
//     };
//   }
// }

class ApiResponse {
  final int code;
  final UserData data;

  ApiResponse({
    required this.code,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] ?? 0,
      data: json.containsKey('data')
          ? UserData.fromJson(json['data'])
          : UserData.fromJson({}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final String name;
  final String loanId;
  final String mobile;
  final String imgPath;
  final String status;
  final String branch;
  final int numberOfLoans;
  final int active;
  final int closed;
  final List<Loan> loans;

  UserData({
    required this.name,
    required this.loanId,
    required this.mobile,
    required this.imgPath,
    required this.status,
    required this.branch,
    required this.numberOfLoans,
    required this.active,
    required this.closed,
    required this.loans,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] ?? '',
      loanId: json['loan_id'] ?? '',
      mobile: json['mobile'] ?? '',
      imgPath: json['imgpath'] ?? '',
      status: json['status'] ?? '',
      branch: json['Branch'] ?? '',
      numberOfLoans: json['no_of_loans'] ?? 0,
      active: json['active'] ?? 0,
      closed: json['closed'] ?? 0,
      loans: (json['loans'] as List<dynamic>?)
              ?.map((i) => Loan.fromJson(i))
              .toList() ??
          [], // ✅ Handle null case by providing an empty list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'loan_id': loanId,
      'mobile': mobile,
      'imgpath': imgPath,
      'status': status,
      'Branch': branch,
      'no_of_loans': numberOfLoans,
      'active': active,
      'closed': closed,
      'loans': loans.map((i) => i.toJson()).toList(),
    };
  }
}

class Loan {
  final String loanNo;
  final String status;
  final double totalAmount;
  final double paidAmount;
  final double balanceAmount;
  final double totalDue;
  final double paidDue;
  final double balanceDue;
  final String? loanStart; // Nullable to prevent crashes
  final String? loanEnd;
  final List<LoanSummary> loanSummary;

  Loan({
    required this.loanNo,
    required this.status,
    required this.totalAmount,
    required this.paidAmount,
    required this.balanceAmount,
    required this.totalDue,
    required this.paidDue,
    required this.balanceDue,
    this.loanStart, // Nullable
    this.loanEnd, // Nullable
    required this.loanSummary,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      loanNo: json['loan_no'] ?? '',
      status: json['status'] ?? '',
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      paidAmount: (json['paid_amount'] ?? 0).toDouble(),
      balanceAmount: (json['balance_amount'] ?? 0).toDouble(),
      totalDue: (json['total_due'] ?? 0).toDouble(),
      paidDue: (json['paid_due'] ?? 0).toDouble(),
      balanceDue: (json['balance_due'] ?? 0).toDouble(),
      loanStart: json['loanstart'], // ✅ Fixed date parsing
      loanEnd: json['loanend'], // ✅ Fixed date parsing
      loanSummary: (json['loansummary'] as List<dynamic>?)
              ?.map((i) => LoanSummary.fromJson(i))
              .toList() ??
          [], // ✅ Handle null case
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_no': loanNo,
      'status': status,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'balance_amount': balanceAmount,
      'total_due': totalDue,
      'paid_due': paidDue,
      'balance_due': balanceDue,
      'loanstart': loanStart,
      'loanend': loanEnd,
      'loansummary': loanSummary.map((i) => i.toJson()).toList(),
    };
  }

  // /// ✅ Utility function to correctly parse "DD-MM-YYYY" dates
  // static DateTime? _parseDate(String? dateString) {
  //   if (dateString == null || dateString.isEmpty) return null;
  //   try {
  //     List<String> parts = dateString.split('-'); // Splitting "20-03-2025"
  //     return DateTime(
  //         int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  //   } catch (e) {
  //     print("Error parsing date: $dateString");
  //     return null; // Prevent crash
  //   }
  // }
}

class LoanSummary {
  final String loanNo;
  final String status;
  final double paidAmount;
  final String? date; // Nullable to prevent crashes

  LoanSummary({
    required this.loanNo,
    required this.status,
    required this.paidAmount,
    this.date,
  });

  factory LoanSummary.fromJson(Map<String, dynamic> json) {
    return LoanSummary(
      loanNo: json['loan_no'] ?? '',
      status: json['status'] ?? '',
      paidAmount: double.tryParse(json['paidamount'].toString()) ??
          0.0, // ✅ Safe parsing
      date: json['date'], // ✅ Fixed date parsing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loan_no': loanNo,
      'status': status,
      'paidamount': paidAmount.toString(),
      'date': date,
    };
  }
}
