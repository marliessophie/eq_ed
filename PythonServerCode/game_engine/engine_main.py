from PythonServerCode.constants import K
from PythonServerCode.game_engine.question_engine import GameEngine

# TODO: delete this file as not needed for production code >> only needed for model updates
from PythonServerCode.game_engine.utilies.item import Question, Answer, Score, Item


def main():
    # here add the level
    engine = GameEngine()
    answers = list()
    # text, score
    answers.append(Answer("Say nothing and see how the discussion evolves.", Score(0, 0),
                          "Y1001", "X1002"))
    answers.append(Answer("Tell Rick that he is being unfair to Morty and he should do the research task instead.",
                          Score(3, 5), "Y1002", "X1005"))
    answers.append(Answer("Say that you think it would be good to take a step back"
                          " and think about which tasks need to be distributed first.", Score(10, 10),
                          "Y1003", "X1008"))
    # question_text, number_of_answers, answers, next_question_id
    new_question = Question(
        "Rick: Alright, now that we have the task I'd say Morty look at news "
        "articles regarding this topic in the last year!" +
        "Morty: I thought we could also..." +
        "Rick: But do it properly this time! I really think we need to be "
        "diligent here. Oh and would be good if you could make a summary for the presentation too.",
        3,
        answers,
        None,
    )
    new_question_item = Item(new_question, "X1001")
    engine.add_item(new_question_item)


if __name__ == "__main__":
    main()
