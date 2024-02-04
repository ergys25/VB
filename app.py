from flask import Flask, render_template, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from os import environ

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = environ.get('DB_URL')
db = SQLAlchemy(app)


class Movie(db.Model):
    __tablename__ = 'movies'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    genre = db.Column(db.String(50), nullable=False)
    year = db.Column(db.Integer, nullable=False)
    director = db.Column(db.String(100), nullable=False)
    rating = db.Column(db.Float, nullable=False)
    description = db.Column(db.Text, nullable=False)
    poster_url = db.Column(db.String(200), nullable=False)

    def json(self):
        return {
            'id': self.id,
            'title': self.title,
            'genre': self.genre,
            'year': self.year,
            'director': self.director,
            'rating': self.rating,
            'description': self.description,
            'poster_url': self.poster_url
        }


db.create_all()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/movies/add', methods=['GET'])
def add_movie_form():
    return render_template('movie_form.html')

# create a test route
@app.route('/test', methods=['GET'])
def test():
    return make_response(jsonify({'message': 'test route'}), 200)


# create a movie
@app.route('/movies', methods=['POST'])
def create_movie():
    try:
        data = request.get_json()
        new_movie = Movie(
            title=data['title'],
            genre=data['genre'],
            year=data['year'],
            director=data['director'],
            rating=data['rating'],
            description=data['description'],
            poster_url=data['poster_url']
        )
        db.session.add(new_movie)
        db.session.commit()
        return make_response(jsonify({'message': 'movie created'}), 201)
    except Exception as e:
        return make_response(jsonify({'message': 'error creating movie'}), 500)


# get all movies
@app.route('/movies', methods=['GET'])
def get_movies():
    try:
        movies = Movie.query.all()
        return make_response(jsonify([movie.json() for movie in movies]), 200)
    except Exception as e:
        return make_response(jsonify({'message': 'error getting movies'}), 500)


# get a movie by id
@app.route('/movies/<int:id>', methods=['GET'])
def get_movie(id):
    try:
        movie = Movie.query.filter_by(id=id).first()
        if movie:
            return make_response(jsonify({'movie': movie.json()}), 200)
        return make_response(jsonify({'message': 'movie not found'}), 404)
    except Exception as e:
        return make_response(jsonify({'message': 'error getting movie'}), 500)


# update a movie
@app.route('/movies/<int:id>', methods=['PUT'])
def update_movie(id):
    try:
        movie = Movie.query.filter_by(id=id).first()
        if movie:
            data = request.get_json()
            movie.title = data['title']
            movie.genre = data['genre']
            movie.year = data['year']
            movie.director = data['director']
            movie.rating = data['rating']
            movie.description = data['description']
            movie.poster_url = data['poster_url']
            db.session.commit()
            return make_response(jsonify({'message': 'movie updated'}), 200)
        return make_response(jsonify({'message': 'movie not found'}), 404)
    except Exception as e:
        return make_response(jsonify({'message': 'error updating movie'}), 500)


# delete a movie
@app.route('/movies/<int:id>', methods=['DELETE'])
def delete_movie(id):
    try:
        movie = Movie.query.filter_by(id=id).first()
        if movie:
            db.session.delete(movie)
            db.session.commit()
            return make_response(jsonify({'message': 'movie deleted'}), 200)
        return make_response(jsonify({'message': 'movie not found'}), 404)
    except Exception as e:
        return make_response(jsonify({'message': 'error deleting movie'}), 500)
