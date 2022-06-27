import 'dart:convert';

class Credits {
    Credits({
        this.id,
        this.cast,
        this.crew,
    });

    int id;
    List<Cast> cast;
    List<Cast> crew;

    factory Credits.fromJson(String str) => Credits.fromMap(json.decode(str));

    factory Credits.fromMap(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );

}

class Cast {
    Cast({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
        this.department,
        this.job,
    });

    get fullprofilePath{
      if(profilePath != null){
        return  'https://image.tmdb.org/t/p/w500${this.profilePath}';
      }else{
        return 'https://www.weact.org/wp-content/uploads/2016/10/Blank-profile.png';
      }
    }

    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String profilePath;
    int castId;
    String character;
    String creditId;
    int order;
    String department;
    String job;

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult               : json["adult"],
        gender              : json["gender"],
        id                  : json["id"],
        knownForDepartment  : json["known_for_department"],
        name                : json["name"],
        originalName        : json["original_name"],
        popularity          : json["popularity"].toDouble(),
        profilePath         : json["profile_path"] == null ? null : json["profile_path"],
        castId              : json["cast_id"] == null ? null : json["cast_id"],
        character           : json["character"] == null ? null : json["character"],
        creditId            : json["credit_id"],
        order               : json["order"] == null ? null : json["order"],
        department          : json["department"] == null ? null : json["department"],
        job                 : json["job"] == null ? null : json["job"],
    );
}
