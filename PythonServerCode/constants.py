from pathlib import Path
import os

from PythonServerCode.game_engine.utilies.components.answer import Answer
from PythonServerCode.game_engine.utilies.components.intro import Intro
from PythonServerCode.game_engine.utilies.components.item import Item
from PythonServerCode.game_engine.utilies.components.question import Question
from PythonServerCode.game_engine.utilies.components.score import Score


class K:
    path = Path(__file__).parent
    cred = os.path.join(path, 'json_schemas/serviceAccountKey.json')
    introX1000 = Item(
        Intro(
            "Setting: User is in a team meeting setting with 2 NPCs. " \
            "They are discussing how to best approach answering the question" \
            " given in an assignment: \"What is the future of work?\". The " \
            "group should create a presentation answering this question. " \
            "The user first listens to the others discussing. ",
            'X1001',
        ),
        'X1000')

    # question item X1001
    answersX1001 = list()
    answersX1001.append(Answer("Say nothing and see how the discussion evolves.", Score(0, 0),
                          "Y1001", "X1002"))
    answersX1001.append(Answer("Tell Rick that he is being unfair to Morty and he should do the research task instead.",
                               Score(3, 5), "Y1002", "X1005"))
    answersX1001.append(Answer("Say that you think it would be good to take a step back"
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
        answersX1001,
        None,
    )
    questionX1001 = Item(new_question, "X1001")

    # question item X1002 - todo change this properly
    answersX1002 = list()
    answersX1002.append(Answer("Say nothing and see how the discussion evolves.", Score(0, 0),
                               "Y1001", "X1002"))
    answersX1002.append(Answer("Tell Rick that he is being unfair to Morty and he should do the research task instead.",
                               Score(3, 5), "Y1002", "X1005"))
    answersX1002.append(Answer("Say that you think it would be good to take a step back"
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
        answersX1002,
        None,
    )
    questionX1002 = Item(new_question, "X1002")




