<?php

function getMessages ($connect) {
    $page = $_GET[page] ? ($_GET[page] - 1) : 0;
    $limit = $_GET[limit] ? $_GET[limit] : 20;
    $first_row = 0 + $limit * $page;

    

    $message = mysqli_query($connect, "SELECT messages.id AS message_id, messages.author_id, messages.datetime, messages.content, authors.datetime_first_message, authors.datetime_last_message, authors.messages_count
    FROM messages 
    INNER JOIN authors ON messages.author_id = authors.id
    WHERE is_banned <> 1 AND is_deleted <> 1
    ORDER BY messages.id
    LIMIT $first_row, $limit");

    $messageList = [];
    while($mes = mysqli_fetch_assoc($message)) {
        $messageList[] = $mes;
    };
    echo json_encode($messageList);
};

function addMessages ($connect, $data) {
    // number of added messages
    $quantity = count($data[messages]);

    $isResult = true;

    foreach ($data[messages] as $value) {

        $params = [
            'message' => $value['message'],
            'phone' => $value['phone']
        ];
        if (!addToTable ($connect, $params)) {
            $isResult = false;
        };
    };

    $resTrue = [
        "status" => "ok",
        "body" => "added " . $quantity,
        "code" => 200,
    ];
    $resFalse = [
        "status" => "error",
        "body" => "not all added",
        "code" => 500
    ];

    $res = $isResult ? $resTrue : $resFalse;
 
    echo json_encode($res);
};

function addToTable ($connect, $params) {
    
    // presence of the author
    $author = mysqli_query($connect, "SELECT `id` FROM `authors` WHERE `phone` = '{$params['phone']}'");
    // if the author is not in the database
    if ($author && mysqli_num_rows($author) === 0) {

        $date = date("Y-m-d H:i:s");

        // adding author
        $author = mysqli_query($connect, "INSERT INTO `authors`(`phone`, `datetime_first_message`, `datetime_last_message`, `messages_count`, `is_banned`) 
            VALUES ('{$params['phone']}','$date','$date','1','0')");
        
        if ($author) {

            $authorId = mysqli_insert_id($connect);
            
            // message splitting
            if (strlen($params['message']) > 10000) {
                
                $arr = str_split($params['message'], 10000);

                foreach ($arr as $value) {
                    $message = mysqli_query($connect, "INSERT INTO `messages`(`author_id`, `datetime`, `content`, `is_deleted`) 
                    VALUES ('$authorId','$date','{$value}','0')");
                };
            } else {
                $message = mysqli_query($connect, "INSERT INTO `messages`(`author_id`, `datetime`, `content`, `is_deleted`) 
                VALUES ('$authorId','$date','{$params['message']}','0')");
            };

        };
        if (!$message) {
            return false;
        };
        return true;
        
    // if the author is in the database
    } elseif ($author && mysqli_num_rows($author) === 1) {

        $date = date("Y-m-d H:i:s");
        $authorId = mysqli_fetch_assoc($author)['id'];

        if (strlen($params['message']) > 10000) {
                
            $arr = str_split($params['message'], 10000);

            foreach ($arr as $value) {
                $insert = mysqli_query($connect, "INSERT INTO `messages`(`author_id`, `datetime`, `content`, `is_deleted`) 
                VALUES ('$authorId','$date','{$value}','0')");
            };
        } else {
            $insert = mysqli_query($connect, "INSERT INTO `messages`(`author_id`, `datetime`, `content`, `is_deleted`) 
            VALUES ('$authorId','$date','{$params['message']}','0')");
        };

        if ($insert) {
            $update = mysqli_query($connect, "UPDATE `authors` SET `datetime_last_message`='$date',`messages_count`=`messages_count` + 1 
            WHERE `id` = '$authorId'");
        };
        if (!$update) {
            return false;
        };
        return true;
    };
};


function deleteMessage ($connect) {

    $delete = mysqli_query($connect, "UPDATE `messages` SET `is_deleted` = 1 WHERE `id` = '$_GET[id]'");

    $res = [
        "status" => "ok",
        "body" => "message deleted",
        "code" => 200,
    ];

    echo json_encode($res);
};