// data/models/blogs_model.dart
import 'dart:convert';

class BlogResponse {
  final bool success;
  final String message;
  final BlogData data;

  BlogResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> json) {
    return BlogResponse(
      success: json['success'],
      message: json['message'],
      data: BlogData.fromJson(json['data']),
    );
  }
}

class BlogData {
  final List<Blog> blogs;
  final Pagination pagination;

  BlogData({
    required this.blogs,
    required this.pagination,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      blogs:
          (json['blogs'] as List).map((blog) => Blog.fromJson(blog)).toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Blog {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final Doctor doctor;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.doctor,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      doctor: Doctor.fromJson(json['doctor']),
    );
  }
}

class Doctor {
  final String id;
  final String fName;
  final String lName;
  final String title;
  final String image;

  Doctor({
    required this.id,
    required this.fName,
    required this.lName,
    required this.title,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fName: json['fName'],
      lName: json['lName'],
      title: json['title'],
      image: json['image'],
    );
  }
}

class Pagination {
  final int currentPage;
  final int total;
  final int numOfPages;

  Pagination({
    required this.currentPage,
    required this.total,
    required this.numOfPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      total: json['total'],
      numOfPages: json['num_of_pages'],
    );
  }
}
