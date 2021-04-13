from pathlib import Path # Using Pathlib built-in module
from tqdm import tqdm # Used for progress bar


def main():
    path = input("Please provide the absolute path: ") # Change the path to where the movies are located
    extansion = input("Enter the extansion of files concerned (ex: jpg, mkv, mp4, ...): ")

    # Extract the WindowsPath(path) object and put it in a list
    # This list looks like [windowsPath(path/to/movie_1.mkv), windowsPath(path/to/movie_2.mkv), ...]
    files = Path(path).glob(f'*.{extansion}') # Change glob to rglob if needing recurssion
    files = [x for x in files]

    # For each movie in the movies list:
    # 1. Init the new movie_folder_path object WindowsPath('path\movie_name\') 
    # 2. Check if this folder already exist (ignore the file & folder creation if folder exist to avoid data loss) and create the folder if not exist
    # 3. Move the movie from path to path\movie_name\
    for f in tqdm(files):
        movie_folder_path = Path(path + '\\' + f.stem)
        if not movie_folder_path.exists():
            movie_folder_path.mkdir()
            f.replace(movie_folder_path / f'{f.name}')


if __name__ == '__main__':
	main()