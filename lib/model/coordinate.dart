class Coordinate {
  int xCoordinate;
  int yCoordinate;

  Coordinate(
    this.xCoordinate,
    this.yCoordinate,
  );

  @override
  String toString() {
    return '($xCoordinate,$yCoordinate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Coordinate && other.xCoordinate == xCoordinate && other.yCoordinate == yCoordinate;
  }

  @override
  int get hashCode => xCoordinate.hashCode ^ yCoordinate.hashCode;

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      json['x'],
      json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': xCoordinate,
      'y': yCoordinate,
    };
  }
}
