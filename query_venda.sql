use vendas;

/** INNER JOIN */
select p.produto_nome, gr.grupo_nome from produto p
inner join grupo gr on p.grupo_codigo = gr.grupo_codigo
order by p.produto_nome ASC, gr.grupo_nome ASC;

/** LEFT JOIN */

SELECT cli.cliente_nome, po.produto_nome, po.produto_punit,it.item_qtde, (po.produto_punit * it.item_qtde) AS total FROM cliente cli 
LEFT JOIN pedido pe ON pe.cliente_id = cli.cliente_id
LEFT JOIN item it on it.pedido_id = pe.pedido_id
LEFT JOIN produto po ON po.produto_codigo = it.produto_id
WHERE cli.cliente_id = 1;

/** RIGHT JOIN */
SELECT * FROM produto po RIGHT JOIN grupo gr 
ON po.grupo_codigo = gr.grupo_codigo;











