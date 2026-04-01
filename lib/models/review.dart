class Review {

  final String comment;
  final String reviewerName;

  const Review({

    required this.comment,
    required this.reviewerName,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(

        comment: json['comment'] as String,
        reviewerName: json['reviewerName'] as String,
      );
}
